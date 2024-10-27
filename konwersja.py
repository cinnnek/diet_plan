import json

# Wczytaj plik JSON
with open("data.json", "r", encoding="utf-8") as file:
    data = json.load(file)

# Miejsce na dane przekształcone
django_data = []

# Funkcja przekształcająca dane tabeli na format Django
def transform_table(table_name, table_data):
    transformed_data = []
    for item in table_data:
        transformed_data.append({
            "model": f"plans.{table_name}",
            "pk": item.get("id") or item.get(f"id_{table_name}") or None,
            "fields": {k: v for k, v in item.items() if k != f"id_{table_name}" and k != "id"}
        })
    return transformed_data

# Przekształć każdą tabelę
for table in data:
    if table["type"] == "table" and "data" in table and table["data"]:
        table_name = table["name"]
        table_data = table["data"]
        django_data.extend(transform_table(table_name, table_data))

# Zapisz wynik w nowym pliku JSON
with open("data_for_django.json", "w", encoding="utf-8") as file:
    json.dump(django_data, file, ensure_ascii=False, indent=4)