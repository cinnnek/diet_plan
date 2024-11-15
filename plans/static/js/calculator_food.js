document.addEventListener("DOMContentLoaded", () => {
    const totalCaloriesDisplay = document.getElementById("totalCalories");
    const selectedProductList = document.getElementById("selectedProductList");
    let caloriesSum = 0;

    // Funkcja dodająca produkt do listy zjedzonych produktów
    function addProduct(id, name, caloriesPer100g) {
        const gramsInput = document.getElementById(`grams-${id}`);
        const grams = parseFloat(gramsInput.value);

        if (isNaN(grams) || grams <= 0) {
            alert("Podaj prawidłową ilość gramów!");
            return;
        }

        const calories = (grams * caloriesPer100g) / 100;
        caloriesSum += calories;
        updateTotalCalories();

        const listItem = document.createElement("li");
        listItem.textContent = `${name} - ${grams}g (${calories.toFixed(2)} kcal)`;

        const deleteButton = document.createElement("button");
        deleteButton.innerText = "Usuń";
        deleteButton.onclick = () => removeProduct(listItem, calories);
        listItem.appendChild(deleteButton);

        selectedProductList.appendChild(listItem);
        gramsInput.value = "";
    }

    // Funkcja aktualizująca wyświetlaną sumę kalorii
    function updateTotalCalories() {
        totalCaloriesDisplay.textContent = `${caloriesSum.toFixed(2)} kcal`;
    }

    // Funkcja usuwająca produkt z listy i aktualizująca sumę kalorii
    function removeProduct(listItem, calories) {
        selectedProductList.removeChild(listItem);
        caloriesSum -= calories;
        updateTotalCalories();
    }

    // Funkcja czyszcząca całą listę zjedzonych produktów
    function clearAllProducts() {
        selectedProductList.innerHTML = "";
        caloriesSum = 0;
        updateTotalCalories();
    }

    // Funkcja filtrowania produktów
    function filterProducts() {
        const searchInput = document.getElementById("search").value.toLowerCase();
        const productList = document.getElementById("productList").getElementsByTagName("li");

        for (let product of productList) {
            const productName = product.textContent.toLowerCase();
            if (productName.includes(searchInput)) {
                product.style.display = "";
            } else {
                product.style.display = "none";
            }
        }
    }

    // Przypisanie funkcji do globalnego obiektu, aby były dostępne w HTML
    window.addProduct = addProduct;
    window.clearAllProducts = clearAllProducts;
    window.filterProducts = filterProducts;
});
