<h2>Web Server Challenge:</h2>

<h3>Milestones:</h3>
<ol>
	<li><del>Respond with ‘Hello World’ and return 200 OK</del></li>
	<li><del>Set a cookie when a user visits</del></li>
	<li><del>Set a 'segments' cookie with the requested path/ID</del></li>
	<li><del>Print the value of 'segments' cookie when a user visit root</del></li>
	<li><del>CSV look up the path/ID and display the corresponding value</del></li>
	<li><del>Append to the existing 'segments' cookie</del></li>
	<li>Switch to use the following format: <b>/:cookie_name/:value</b></li>
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
