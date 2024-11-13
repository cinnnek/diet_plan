function calculateCPM() {

    const weight = document.getElementById("weight").value;
    const height = document.getElementById("height").value;
    const age = document.getElementById("age").value;
    const gender = document.getElementById("gender").value;
    const activity = document.getElementById("activity").value;
    const errorMessage = document.getElementById("errorMessage");
    const cpmValue = document.getElementById("cpmValue");

    if (!weight || !height || !age || !gender || !activity) {
        errorMessage.style.display = "block";
        cpmValue.textContent = "";
        return;
    }

    // błąd
    errorMessage.style.display = "none";

    // PPM
    let ppm;
    if (gender === "female") {
        ppm = 655.1 + (9.563 * weight) + (1.85 * height) - (4.676 * age);
    } else if (gender === "male") {
        ppm = 66.5 + (13.75 * weight) + (5.003 * height) - (6.775 * age);
    }

    // CPM
    const cpm = ppm * parseFloat(activity);

    cpmValue.textContent = cpm.toFixed(2);
}
