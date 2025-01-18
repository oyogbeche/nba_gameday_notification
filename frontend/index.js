function ShowAlert(message, type) {
    const alertBox = document.getElementById("alert-box");
    const alertMessage = document.getElementById("alertMessage");
    const okButton = document.getElementById("okButton");

    alertMessage.innerText = message;
    alertBox.style.display = "block";
    alertBox.style.backgroundColor = type === "success" ? "#4CAF50" : "#f44336";
    alertBox.style.color = "#fff";

    okButton.onclick = () => {
        alertBox.style.display = "none";
    };
}

const form = document.getElementById("preferencesForm");

form.addEventListener("submit", async function(event) {
    event.preventDefault();

    // Get form values
    const email = document.getElementById("email").value;
    const preferencesInput = document.getElementById("preferences").value;
    const preferences = preferencesInput
        .split(",") 
        .map(pref => pref.trim()) 
        .filter(pref => pref.length > 0);

    

    // Prepare the data payload
    const data = {
        email: email,
        preferences: preferences
    };

    try {
        const response = await fetch('https://91vjrqbbtl.execute-api.eu-west-1.amazonaws.com/dev/preferences', {
            method: 'POST',
            mode: 'cors',
            body: JSON.stringify(data)
        });

        if (response.status === 200) {
            ShowAlert("Favorite teams saved successfully! Please verify your email.", "success");
        } else {
            ShowAlert("Failed to save favorite teams. Please try again.", "error");
        }
    } catch (error) {
        ShowAlert("An error occurred while submitting the form.", "error");
    }
});
