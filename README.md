# Simple FastApi project utilizing GitHubActions for CI/CD

This simple FastApi project application demonstrates the process from commiting code to deploying to an EC2 instance, available to the public. 

# More in-depth explanation

The application itself is non-essential, the key focus lies in the deployment process.
The project has 3 branches: code_review, dev and prod. The idea is the developer creates new branches of code_review, and then merges to branch code_review. When the code is ready, a new pr is made to merge code_review to dev. This process triggers
an action which runs tests on the code and builds and pushes the dockerized image of the application, using the Dockerfile specified, to github container registry. Then a pr from dev to prod is set, and manually we can set a second trigger which connects
to an EC2 instance in AWS. Inside the EC2 instance we pull the image from github container registry and run the container.
