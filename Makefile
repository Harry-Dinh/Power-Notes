# Committing code to GitHub (from current branch)
commit:
	echo "COMMITTING CODE TO GITHUB FROM CURRENT BRANCH"
	echo "============================================="
	git add .
	git commit -m "$(MSG)" -m "$(DESC)"
	git push
	echo ""
	git status