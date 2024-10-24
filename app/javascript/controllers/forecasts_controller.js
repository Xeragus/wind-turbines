import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  async forecast(event) {
    console.log('VLAGA VO forecasts controller')
    event.preventDefault();

    // Show loading state
    const button = event.currentTarget;
    button.innerText = "Loading...";
    button.disabled = true;

    const readingId = button.getAttribute('data-id');

    try {
      // Send request to forecast action
      const response = await fetch(`/wind_turbine_readings/${readingId}/forecast`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({ id: readingId })
      });

      if (!response.ok) {
        throw new Error('Network response was not ok');
      }

      // Wait for 10 seconds to simulate processing
      await new Promise(resolve => setTimeout(resolve, 10000));

      // Handle the response from the server (for example, update the DOM)
      const result = await response.text();
      // Assuming you want to update the results in a specific element
      document.getElementById("forecast-results").innerHTML = result;

      } catch (error) {
        console.error('There was a problem with the fetch operation:', error);
      } finally {
        // Reset button state
        button.innerText = "Forecast";
        button.disabled = false;
      }
  }
}
