document.addEventListener("DOMContentLoaded", function() {
    const meals = JSON.parse(document.getElementById("meals-data").textContent);
    const selectedMeals = JSON.parse(document.getElementById("selected-meals-data").textContent);

    // Sortuj posiłki po kaloriach
    meals.sort((a, b) => a.kcal - b.kcal);

    function showMealSelectors() {
        const mealCount = document.getElementById("mealCount").value;
        const mealSelectors = document.getElementById("mealSelectors");
        mealSelectors.innerHTML = "";

        for (let i = 0; i < mealCount; i++) {  // Używamy indeksu dla selectedMeals
            const mealDiv = document.createElement("div");
            mealDiv.className = "mb-3";

            const label = document.createElement("label");
            label.textContent = "Posiłek " + (i + 1) + ":";
            label.className = "form-label";
            mealDiv.appendChild(label);

            const select = document.createElement("select");
            select.name = "selected_meals";
            select.className = "form-select";

            const defaultOption = document.createElement("option");
            defaultOption.value = "";
            defaultOption.textContent = "Wybierz posiłek " + (i + 1);
            defaultOption.disabled = true;
            select.appendChild(defaultOption);

            meals.forEach(meal => {
                const option = document.createElement("option");
                option.value = meal.id_posilku;
                option.textContent = `${meal.nazwa} - ${meal.kcal} kcal`;
                option.dataset.kcal = meal.kcal;

                // Ustaw wybrany posiłek, jeśli odpowiada temu w `selectedMeals`
                if (selectedMeals[i] && selectedMeals[i] === meal.id_posilku) {
                    option.selected = true;
                }

                select.appendChild(option);
            });

            select.addEventListener("change", updateCalories);
            mealDiv.appendChild(select);
            mealSelectors.appendChild(mealDiv);
        }

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


    document.getElementById("mealCount").value = 5;
    showMealSelectors();
    document.getElementById("mealCount").addEventListener("change", showMealSelectors);
});
