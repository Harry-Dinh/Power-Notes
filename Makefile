# Committing code to GitHub (from current branch)

# This command prevents all of the commands from being echoed to the terminal and only show their outputs
.SILENT:

commit:
	echo "COMMITTING CODE TO GITHUB FROM CURRENT BRANCH"
	echo "============================================="
	git add .
	git commit -m "$(MSG)" -m "$(DESC)"
	git push
	echo ""
	git status
