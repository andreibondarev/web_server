<h2>Web Server Challenge:</h2>

<h3>Milestones:</h3>
<ol>
	<li><strike>Respond with ‘Hello World’ and return 200 OK</strike></li>
	<li><strike>Set a cookie when a user visits</strike></li>
	<li><strike>Set a 'segments' cookie with the requested path/ID</strike></li>
	<li><strike>Print the value of 'segments' cookie when a user visit root</strike></li>
	<li><strike>CSV look up the path/ID and display the corresponding value</strike></li>
	<li><strike>Append to the existing 'segments' cookie</strike></li>
	<li>Switch to using the following format:</li>
		<ul>
			<li>/:cookie_name/:value</li>
		</ul>
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
