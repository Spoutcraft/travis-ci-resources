if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
    echo -e "Changing directory to $HOME and configuring git"
    cd $HOME
    git config --global user.email "travis@travis-ci.org"
    git config --global user.name "Travis"

    echo -e "Cloning gh-pages repo using token"
    git clone --quiet --branch=gh-pages https://$GH_TOKEN@github.com/$TRAVIS_REPO_SLUG.git gh-pages > /dev/null

    echo -e "Copy apidocs to gh-pages repo root"
    cd gh-pages
    cp -Rf $TRAVIS_BUILD_DIR/target/site/apidocs/* .

    echo -e "Adding, committing, and pushing apidocs to gh-pages repo"
    git add -f .
    git commit -m "Update JavaDocs for Travis build $TRAVIS_BUILD_NUMBER"
    git push -q origin gh-pages > /dev/null
fi
