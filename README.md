# IMDB_Analysis
<p>use bright data  to get the csv data where to and export data to snowflake</p>
<p>To learn more about SnowSQL, visit the <a href="https://developers.snowflake.com/snowsql/">SnowSQL Download</a>.</p>
<h5>Follow the steps below to create a database in snowflake:</h5>
// Define the image URLs
const brightdataPageURL = "https://github.com/mhimavarsha/IMDB_Analysis/blob/main/images/Brightdata_page.png";
const loginPageURL = "https://github.com/mhimavarsha/IMDB_Analysis/blob/main/images/login_page.png";
const warehouseURL = "https://github.com/mhimavarsha/IMDB_Analysis/blob/main/images/warehouse.png";
const fileFormatURL = "https://github.com/mhimavarsha/IMDB_Analysis/blob/main/images/file_format.png";
const stageURL = "https://github.com/mhimavarsha/IMDB_Analysis/blob/main/images/create_stage.png";

// Create anchor tags for each image
const brightdataPageLink = `<a href="${brightdataPageURL}">Brightdata Page</a>`;
const loginPageLink = `<a href="${loginPageURL}">Login Page</a>`;
const warehouseLink = `<a href="${warehouseURL}">Warehouse</a>`;
const fileFormatLink = `<a href="${fileFormatURL}">File Format</a>`;
const stageLink = `<a href="${stageURL}">Stage</a>`;

// Append the links to a container element (e.g., a div)
const container = document.getElementById("image-links");
container.innerHTML = `${brightdataPageLink}<br>${loginPageLink}<br>${warehouseLink}<br>${fileFormatLink}<br>${stageLink}`;

