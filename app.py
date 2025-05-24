from flask import Flask, jsonify, request, session, render_template
from flask_cors import CORS
import mysql.connector
import requests
from bs4 import BeautifulSoup
import random
import string
import json
from urllib.parse import urlparse, parse_qs, urlencode, urlunparse, urljoin
from time import sleep
import re
from playwright.sync_api import sync_playwright
import os
import asyncio




app = Flask(__name__)
app.secret_key = ''.join(random.choices(string.ascii_letters + string.digits, k=32))
CORS(app)
#SEARCH1API_KEY = "28811D8D-891E-496F-BD9D-ABD6430DD96F"
#SEARCH1API_KEY = "156002FF-4EAC-46BA-9BF7-1C63960DB079"
SEARCH1API_KEY = ""
SEARCH1API_URL = "https://api.search1api.com/search"
#IPSTACK_KEY = "b3ac539a3982e92086aca92c671cf91c"
IPSTACK_KEY = "0f427197b46ab64fe57aa0166ae9689d"

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="gameenigma"
)
cursor = db.cursor(dictionary=True)

def get_user_region():
    try:
        response = requests.get(f"http://api.ipstack.com/check?access_key={IPSTACK_KEY}")
        data = response.json()
        print("Getting country..")
        country = data.get("country_name", "Unknown")
        print(f"Detected country: {country}")
        return country
    except Exception as e:
        print("Could not detect region:", e)
        return "Unknown"

def make_api_request(url, headers, payload, max_retries=3):
    for attempt in range(max_retries):
        try:
            response = requests.post(url, headers=headers, json=payload)
            if response.status_code != 429:
                return response
            wait_time = (attempt + 1) * 5  
            print(f"Rate limited. Waiting {wait_time} seconds...")
            sleep(wait_time)
        except Exception as e:
            print(f"Attempt {attempt + 1} failed: {str(e)}")
            if attempt == max_retries - 1:
                raise
    return response

def get_top_stores(region):
    query = f"top online computer hardware store in {region}" if region != "Unknown" else "top online computer hardware store"

    payload = {
        "query": query,
        "search_service": "google",
        "max_results": 2,
        "language": "en"
    }
    excluded_domains = [
        "wikipedia.org", "reddit.com", "quora.com", "youtube.com",
        "facebook.com", "linkedin.com", "twitter.com", "instagram.com",
        "pinterest.com", "news.google.com"
    ]
    
    try:
        print(f"🔍 Searching for: {query}")
        response = requests.post(SEARCH1API_URL, json=payload, timeout=10)

        if response.status_code == 200:
            results = response.json().get("results", [])
            store_urls = []
            for result in results:
                store_url = result.get("link", "")
                if store_url:
                    parsed = urlparse(store_url)
                    domain = parsed.netloc.replace("www.", "").lower()
                    if any(excluded in domain for excluded in excluded_domains):
                        continue
                    clean_url = urlparse(store_url)._replace(query=None).geturl()
                    store_urls.append(clean_url.rstrip("/"))
            return store_urls
        else:
            print(f"❌ API Error: {response.status_code} - {response.text}")
    except Exception as e:
        print(f"🚨 Request failed: {str(e)}")
    
    return []

def clean_url(url):
    parsed_url = urlparse(url)
    cleaned_url = urlunparse(parsed_url._replace(query=''))
    return cleaned_url.rstrip("/")

def get_next_higher_component_name(component_type, current_score):
    table = "cpuinfo" if component_type == "CPU" else "gpuinfo"
    column = "CpuScore" if component_type == "CPU" else "GpuScore"
    name_column = "CpuName" if component_type == "CPU" else "GpuName"

    query = f"""
        SELECT {name_column}, {column}
        FROM {table}
        WHERE {column} > %s
        ORDER BY {column} ASC
        LIMIT 1
    """
    cursor.execute(query, (current_score,))
    print(f"query: {query}")
    row = cursor.fetchone()
    print(f"next component: {row}")
    return row[name_column] if row else None


def search_product_on_store(store_url, product_name, component_type):
    domain = urlparse(store_url).netloc
    headers = { "Content-Type": "application/json" }
    print("On search product....")

    if component_type.lower() == "ram":
        print("Ram searching....")
        if product_name <= 4 :
            ram_size = 4
            busspeed = 2660
        elif product_name > 4 and product_name <= 8 :
            ram_size = 8
            busspeed = 3600
        elif product_name > 8 and product_name <= 16:
            ram_size = 16
            busspeed = 3600
        elif product_name > 16 and product_name <= 32:
            ram_size = 32
            busspeed = 3600
        payload = {
            "query": f"site:{domain} {ram_size} GB DDR4 {busspeed} MHz Desktop RAM buy in stock available",
            "search_service": "google",
            "max_results": 5,
            "language": "en"
        }

        print(f"🔍 RAM Payload: {payload}")
        try:
            response = make_api_request(SEARCH1API_URL, headers, payload)
            print(f"📦 RAM API Response Status: {response.status_code if response else 'No response'}")
            if response and response.status_code == 200:
                results = response.json().get("results", [])
                print(f"📄 RAM Results found: {len(results)}")

                all_prices = []
                for result in results:
                    product_url = clean_url(result["link"])
                    price = scrape_price_from_page(product_url)
                    if price is not None and price > 0:
                        all_prices.append((price, product_url))
                    else:
                        print(f"Skipping {product_url} due to invalid or missing price")

                if all_prices:
                    cheapest = min(all_prices, key=lambda x: x[0])
                    print(f"✅ Found cheapest {ram_size} RAM: {cheapest[1]} at price {cheapest[0]}")
                    return cheapest[1]
                else:
                    print("⚠️ No valid prices found.")
            else:
                print(f"❌ RAM API failed or returned empty results.")
        except Exception as e:
            print(f"❌ Exception during RAM search: {str(e)}")
        return "Not found"

    else:
        print("CPU or GPU searching...")
        if component_type == "CPU":
            component_key = "GPU"
        elif component_type == "GPU":
            component_key = "CPU"
        table = "cpuinfo" if component_key == "CPU" else "gpuinfo"
        name_column = "CpuName" if component_key == "CPU" else "GpuName"
        score_column = "CpuScore" if component_key == "CPU" else "GpuScore"

        current_name = product_name
        print(f"name: {current_name}")

        while current_name:
            payload = {
                "query": f"site:{domain} \"{current_name}\"",
                "search_service": "google",
                "max_results": 1,
                "language": "en"
            }

            print(f"🔍 {component_key.upper()} Payload: {payload}")
            try:
                response = make_api_request(SEARCH1API_URL, headers, payload)
                if response and response.status_code == 200:
                    results = response.json().get("results", [])
                    for result in results:
                        cleaned_url = clean_url(result["link"])
                        price = scrape_price_from_page(cleaned_url)
                        if price is not None and price > 0:
                            print(f"✅ Found product: {cleaned_url} with price {price}")
                            return cleaned_url
                        else:
                            print(f"Skipping {cleaned_url} due to invalid or missing price")
                else:
                    print(f"❌ No results for {current_name}")
            except Exception as e:
                print(f"❌ Exception during search: {str(e)}")
            try:
                cursor.execute(f"SELECT {score_column} FROM {table} WHERE {name_column} = %s", (current_name,))
                row = cursor.fetchone()
                print(f"row {row}")
                if not row:
                    break  

                current_score = row[score_column]
                print(f"Current Score: {current_score}")
                next_name = get_next_higher_component_name(component_key, current_score)
                print(f"Next Name: {next_name}")
                if not next_name:
                    print(f"⚠️ No better {component_key.upper()} found in DB.")
                    break
                print(f"🔁 Trying next better {component_key.upper()}: {next_name}")
                current_name = next_name
            except Exception as e:
                print(f"❌ Failed fallback logic for {component_key.upper()}: {str(e)}")
                break

        return "Not found"


def extract_store_name(url):
    parsed = urlparse(url)
    domain = parsed.netloc
    if domain.startswith('www.'):
        domain = domain[4:]
    name = domain.split('.')[0]
    return name.capitalize()


def search_parts_for_top_stores(region, cpu_name, gpu_name, ram_name):
    stores = get_top_stores(region)
    store_product_links = {}

    for store in stores:
        print(f"\n🏬 Searching products on: {store}")
        products = {
            "CPU": search_product_on_store(store, cpu_name, "GPU"), 
            "GPU": search_product_on_store(store, gpu_name, "CPU"), 
            "RAM": search_product_on_store(store, ram_name, "ram") 
        }
        store_name = extract_store_name(store) 
        store_product_links[store_name] = products

    return store_product_links



def scrape_price_from_page(url):
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()
        page.goto(url)
        page.wait_for_timeout(3000) 

        selectors = [
            ".product-price label",
            ".product-price span",
            ".product-price div",
            ".price", 
            ".product-price",
            ".price-tag",
            "[class*=price]"
        ]

        for selector in selectors:
            elements = page.query_selector_all(selector)
            for el in elements:
                text = el.inner_text().strip()
                if el.evaluate("e => e.tagName.toLowerCase()") == "del":
                    continue
                match = re.search(r"\d{1,3}(,\d{3})*(৳)?", text)
                if match:
                    price_str = match.group(0)
                    print(f"💬 Found price string: {price_str}")
                    cleaned_price = float(price_str.replace(",", "").replace("৳", ""))
                    print(f"✅ Final cleaned price: {cleaned_price}")
                    return cleaned_price

        print(f"❌ No valid price found on {url}")
        return None
    
    

@app.route('/All-game-info')
def All_game_info():
    cursor.execute("SELECT * FROM gameinfo")
    all_games=cursor.fetchall()
    return jsonify(all_games)


@app.route('/game-info')
def game_info():
    gid = request.args.get('gid')
    cursor.execute("SELECT * FROM gameinfo WHERE GID = %s", (gid,))
    return jsonify(cursor.fetchone())


@app.route('/system-requirements')
def system_requirements():
    gid = request.args.get('gid')  
    cursor.execute("SELECT * FROM gameinfo WHERE GID = %s", (gid,))
    game_info = cursor.fetchone()
    

    if game_info is None:
        return jsonify({"error": "Game information not found."}), 500
    cursor.execute("SELECT * FROM systemrequirement WHERE GID = %s", (gid,))
    req = cursor.fetchone()
    cursor.fetchall()  

    if req is None:
        return jsonify({"error": "System requirements not found."}), 500
    cursor.execute("SELECT * FROM cpuinfo WHERE CpuID = %s", (req['Mincpu'],))
    min_cpu = cursor.fetchone()
    cursor.fetchall()  

    cursor.execute("SELECT * FROM cpuinfo WHERE CpuID = %s", (req['Maxcpu'],))
    max_cpu = cursor.fetchone()
    cursor.fetchall()  

    cursor.execute("SELECT * FROM gpuinfo WHERE GpuID = %s", (req['Mingpu'],))
    min_gpu = cursor.fetchone()
    cursor.fetchall()  

    cursor.execute("SELECT * FROM gpuinfo WHERE GpuID = %s", (req['Maxgpu'],))
    max_gpu = cursor.fetchone()
    cursor.fetchall()  
    return jsonify({
        "min_cpu": min_cpu,
        "max_cpu": max_cpu,
        "min_gpu": min_gpu,
        "max_gpu": max_gpu,
        "min_ram": game_info.get("MinRAM", "Not Available"),  
        "max_ram": game_info.get("MaxRAM", "Not Available"), 
        "game_size": game_info.get("GameSize", "Not Available"),  
    })


@app.route('/cpu-search')
def cpu_search():
    q = request.args.get('q', '')
    cursor.execute("SELECT CpuName FROM cpuinfo WHERE CpuName LIKE %s", (f"%{q}%",))
    return jsonify([row['CpuName'] for row in cursor.fetchall()])

@app.route('/gpu-search')
def gpu_search():
    q = request.args.get('q', '')
    cursor.execute("SELECT GpuName FROM gpuinfo WHERE GpuName LIKE %s", (f"%{q}%",))
    return jsonify([row['GpuName'] for row in cursor.fetchall()])



@app.route('/check-compatibility', methods=['POST'])
def check_compatibility():
    data = request.json
    user_cpu = data['cpu']
    user_gpu = data['gpu']
    user_ram = int(data['ram'])
    gid = int(data['gid'])
    
    cursor.execute("SELECT GID, MinRAM, MaxRAM FROM gameinfo WHERE GID = %s", (gid,))
    game_info = cursor.fetchone()
    if not game_info:
        return jsonify({"error": "Game info not found"}), 500
    gid = game_info['GID']
    min_ram = game_info['MinRAM']
    max_ram = game_info['MaxRAM']


    cursor.execute("SELECT CpuScore FROM cpuinfo WHERE CpuName = %s", (user_cpu,))
    cpu_row = cursor.fetchone()

    cursor.execute("SELECT GpuScore FROM gpuinfo WHERE GpuName = %s", (user_gpu,))
    gpu_row = cursor.fetchone()


    cursor.execute("SELECT Mincpu, Mingpu, Maxcpu, Maxgpu FROM systemrequirement WHERE GID = %s", (gid,))
    req_list = cursor.fetchall()
    if not req_list:
        return jsonify({"error": "System requirement not found"}), 500

    min_cpu_scores = []
    max_cpu_scores = []
    for req in req_list:
        mincpu_id = req['Mincpu']
        cursor.execute("SELECT CpuScore FROM cpuinfo WHERE CpuID = %s", (mincpu_id,))
        mincpu_row = cursor.fetchone()
        if mincpu_row:
            min_cpu_scores.append(mincpu_row['CpuScore'])

        maxcpu_id = req['Maxcpu']
        cursor.execute("SELECT CpuScore FROM cpuinfo WHERE CpuID = %s", (maxcpu_id,))
        maxcpu_row = cursor.fetchone()
        if maxcpu_row:
            max_cpu_scores.append(maxcpu_row['CpuScore'])

    if not min_cpu_scores or not max_cpu_scores:
        return jsonify({"error": "CPU scores not found"}), 500

    min_cpu_score = min(min_cpu_scores)
    max_cpu_score = max(max_cpu_scores)

    min_gpu_scores = []
    max_gpu_scores = []
    for req in req_list:
        mingpu_id = req['Mingpu']
        cursor.execute("SELECT GpuScore FROM gpuinfo WHERE GpuID = %s", (mingpu_id,))
        mingpu_row = cursor.fetchone()
        if mingpu_row:
            min_gpu_scores.append(mingpu_row['GpuScore'])

        maxgpu_id = req['Maxgpu']
        cursor.execute("SELECT GpuScore FROM gpuinfo WHERE GpuID = %s", (maxgpu_id,))
        maxgpu_row = cursor.fetchone()
        if maxgpu_row:
            max_gpu_scores.append(maxgpu_row['GpuScore'])

    if not min_gpu_scores or not max_gpu_scores:
        return jsonify({"error": "GPU scores not found"}), 500

    min_gpu_score = min(min_gpu_scores)
    max_gpu_score = max(max_gpu_scores)
    

    compatible = (
    cpu_row['CpuScore'] >= min_cpu_score and
    gpu_row['GpuScore'] >= min_gpu_score and
    user_ram >= min_ram
)

    result = {
    "compatible": compatible,
    "user_scores": {
        "cpu": cpu_row['CpuScore'],
        "gpu": gpu_row['GpuScore'],
        "ram": user_ram
    },
    "required_scores": {
        "min_cpu": min_cpu_score,
        "max_cpu": max_cpu_score,
        "min_gpu": min_gpu_score,
        "max_gpu": max_gpu_score,
        "min_ram": min_ram,
        "max_ram": max_ram
    }
}
    print(f"{result}")
    return jsonify(result)



@app.route('/get-basic-parts', methods=['GET'])
def get_basic_parts():
    gid = request.args.get('gid', type=int)
    cursor.execute("SELECT * FROM systemrequirement WHERE GID = %s LIMIT 1", (gid,))
    sysreq = cursor.fetchone() 
    cursor.execute("SELECT MinRAM FROM gameinfo WHERE GID = %s", (gid,))
    minram= cursor.fetchone()
    region= get_user_region()
    print("Starting....")
    if sysreq:
        cursor.execute("SELECT CpuName FROM cpuinfo WHERE CpuID = %s", (sysreq['Mincpu'],))
        min_cpu = cursor.fetchone()  
        print("min cpu :")
        cursor.execute("SELECT CpuName FROM cpuinfo WHERE CpuID = %s", (sysreq['Maxcpu'],))
        max_cpu = cursor.fetchone()  
        cursor.execute("SELECT GpuName FROM gpuinfo WHERE GpuID = %s", (sysreq['Mingpu'],))
        min_gpu = cursor.fetchone()  
        cursor.execute("SELECT GpuName FROM gpuinfo WHERE GpuID = %s", (sysreq['Maxgpu'],))
        max_gpu = cursor.fetchone() 
        print("starting search")
        min_cpu_name = min_cpu['CpuName'] if min_cpu else ''
        min_gpu_name = min_gpu['GpuName'] if min_gpu else ''
        min_ram_size = minram['MinRAM'] if minram else ''
        Productlinks=search_parts_for_top_stores(region,min_cpu_name,min_gpu_name,min_ram_size)
        
        product_list = [
            {
                'store': store,
                'CPU': parts['CPU'],
                'GPU': parts['GPU'],
                'RAM': parts['RAM']
            } for store, parts in Productlinks.items()
        ]
        #product_list = [{'store': 'Startech', 
        #                 'CPU': 'https://www.startech.com.bd/amd-ryzen-5-5600g-processor', 
        #                 'GPU': 'https://www.startech.com.bd/colorful-geforce-rtx-3060-nb-duo-12g-v2-lv-graphics-card', 
        #                 'RAM': 'https://www.startech.com.bd/g-skill-trident-z-neo-rgb-8gb-desktop-ram'},
        #                {'store': 'Ryans', 
        #                 'CPU': 'https://www.ryans.com/amd-ryzen-5-5600g-desktop-processor', 
        #                 'GPU': 'https://www.ryans.com/zotac-gaming-geforce-rtx-3060-twin-edge-12gb-gddr6-graphics-card', 
        #                 'RAM': 'https://www.ryans.com/adata-xpg-spectrix-d35g-rgb-8gb-ddr4-3600mhz-black-gaming-desktop-ram'}]
        print(f"{product_list}")
        return jsonify({'Productlinks': product_list})
    else:
        return jsonify({'error': 'No system requirements found for the provided GID'})


def extract_best_image_from_name(page, product_name):
    all_images = page.query_selector_all("img")
    product_name_keywords = re.findall(r'\w+', product_name.lower())  

    best_match = ""
    highest_match_count = 0

    for img in all_images:
        src = img.get_attribute("src")
        if not src or "data:image" in src:
            continue 
        src_lower = src.lower()
        match_count = sum(1 for word in product_name_keywords if word in src_lower)
        if match_count > highest_match_count:
            highest_match_count = match_count
            best_match = src

    if best_match:
        print(f"🖼️ Selected product image by name match: {best_match}")
        return best_match
    else:
        print("❌ No product image matched with name.")
        return ""


def scrape_product(url):
    def extract_price(page):
        selectors = [
            ".product-price label",
            ".product-price span",
            ".product-price div",
            ".price", 
            ".product-price",
            ".price-tag",
            "[class*=price]"
        ]

        for selector in selectors:
            elements = page.query_selector_all(selector)
            for el in elements:
                text = el.inner_text().strip()
                if el.evaluate("e => e.tagName.toLowerCase()") == "del":
                    continue
                match = re.search(r"\d{1,3}(,\d{3})*(৳)?", text)
                if match:
                    price_str = match.group(0)
                    print(f"💬 Found price string: {price_str}")
                    cleaned_price = float(price_str.replace(",", "").replace("৳", ""))
                    print(f"✅ Final cleaned price: {cleaned_price}")
                    return f"{cleaned_price}৳"

        print(f"❌ No valid price found on {url}")
        return "Price not found"

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()
        try:
            page.goto(url, timeout=15000)
            page.wait_for_load_state("networkidle")
            name = page.title()
            image = extract_best_image_from_name(page,name)
            price = extract_price(page)
        except Exception as e:
            name = "Failed to fetch product"
            image = ""
            price = str(e)
        finally:
            browser.close()
    return {
        "name": name,
        "image": image,
        "price": price,
        "link": url
    }

@app.route('/scrape-products', methods=['GET'])
def scrape_products():
    product_url = request.args.get('data', type=str)
    print(f"🔎 Scraping from: {product_url}")
    result = scrape_product(product_url)
    print(f"✅ Scraped result: {result}")
    return jsonify(result)



if __name__ == '__main__':
    app.run(debug=True)


