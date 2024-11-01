document.addEventListener("DOMContentLoaded", function() {

    const meals = JSON.parse(document.getElementById("meals-data").textContent);
    meals.sort((a, b) => a.kcal - b.kcal);

    function showMealSelectors() {
        const mealCount = document.getElementById("mealCount").value;
        const mealSelectors = document.getElementById("mealSelectors");
        mealSelectors.innerHTML = ""; // Wyczyść poprzednie listy rozwijane

        for (let i = 1; i <= mealCount; i++) {
            const mealDiv = document.createElement("div");
            mealDiv.className = "mb-3";

            const label = document.createElement("label");
            label.textContent = "Posiłek " + i + ":";
            label.className = "form-label";
            mealDiv.appendChild(label);

            const select = document.createElement("select");
            select.name = "selected_meals";
            select.className = "form-select";
            select.addEventListener("change", updateCalories);

            // Dodanie domyślnej opcji "Wybierz posiłek"
            const defaultOption = document.createElement("option");
            defaultOption.value = "";
            defaultOption.textContent = "Wybierz posiłek " + i;
            defaultOption.disabled = true;
            defaultOption.selected = true;
            select.appendChild(defaultOption);

            meals.forEach(meal => {
                const option = document.createElement("option");
                option.value = meal.id_posilku;
                option.textContent = `${meal.nazwa} - ${meal.kcal} kcal`;
                option.dataset.kcal = meal.kcal;
                select.appendChild(option);
            });

            mealDiv.appendChild(select);
            mealSelectors.appendChild(mealDiv);
        }

        // Zaktualizuj kalorie po wygenerowaniu selektorów
        updateCalories();
    }

    function updateCalories() {
        const selectors = document.querySelectorAll("select[name='selected_meals']");
        let totalCalories = 0;

        selectors.forEach(select => {
            const selectedOption = select.options[select.selectedIndex];
            const kcal = parseInt(selectedOption.dataset.kcal) || 0;
            totalCalories += kcal;
        });

        document.getElementById("totalCalories").textContent = `Suma kalorii: ${totalCalories} kcal`;
    }

    document.querySelector(".btn-primary").addEventListener("click", function(event) {
        event.preventDefault();

        const selectedMeals = Array.from(document.querySelectorAll("select[name='selected_meals']"))
            .map(select => select.value);

        // Sprawdzenie, czy wszystkie posiłki zostały wybrane
        if (selectedMeals.includes("")) {
            alert("Proszę wybrać wszystkie posiłki.");
            return;
        }

        const baseUrl = new URL(window.location.origin + customPlanDetailUrl);
        selectedMeals.forEach(mealId => baseUrl.searchParams.append("meals", mealId));

        window.location.href = baseUrl;
    });

    document.getElementById("mealCount").value = 3;
    showMealSelectors();
    document.getElementById("mealCount").addEventListener("change", showMealSelectors);
});
