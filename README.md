<h2>Web Server Challenge:</h2>

<h3>Milestones:</h3>
<ol>
	<li>Respond with ‘Hello World’ and return 200 OK</li>
	<li>Set a cookie when a user visits</li>
	<li>Set a 'segments' cookie with the requested path/ID</li>
	<li>Print the value of 'segments' cookie when a user visits root</li>
	<li>CSV look up the path/ID and display the corresponding value</li>
	<li>Append to the existing 'segments' cookie</li>
</ol>

<h3>Usage</h3>
<ol>
	<li>Run 'ruby webserver.rb'</li>
	<li>Navigate to 'localhost:3000' to '/' (root) or specify an ID</li>
		<ul>
			<li>Navigating to root prints out the 'segments' cookie</li>
			<li>A specified path/ID (/111 for example) will be matched to the lookup.csv file and printed out</li>
		</ul>
</ol>
