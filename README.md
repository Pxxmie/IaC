# Infrastructure as Code (IaC) and Ansible

### What is Infrastructure as Code? 

Infrastructure as Code is the automation of infrastructure needed for the end-to-end deployment of an application.

- Aims reduce time and effort needed to manage the deployment process of an application.

- There will be an increase in software deployment and speed.
  
-  IaC reduces human errors. 


### What is Ansible? 

Ansible is an open-source infrastructure as a code tool. 
- Ansible is often recognised as a simple beginner-friendly tool
  
- It helps automate the configuration of multiple servers at once, rather than connecting to an individual server and then carrying out your desired task.

![Alt text](images/Iac_ansible.png)
# Setting Up Ansible on EC2 Instance

In this document, we are launching an EC2 instance and configuring it with Ansible,

### Step 1: Create an EC2 Instance for Ansible Controller

- Log in to your AWS and create/launch a new EC2 instance.
  - Provide a name for your instance, such as *ansible-controller*.
  - Choose the AMI (Amazon Machine Image) and select the community AMI with Ubuntu 20.04 LTS. 
  - Select t2.micro for instance type. 
  - Select the existing key pair that you usually use. This will be used for SSH access.
  - Under network settings, choose an existing security group that allows inbound traffic on ports SSH, HTTP, HTTPS, and port 3000. (create a security group to these ports.)

### Step 2: Connect to Your EC2 Instance via SSH

- Open your Gitbash terminal and use the cd command to change the directory to where your SSH key is located.
- Use the following command to establish an SSH connection to your EC2 instance: 
  ``` 
  ssh -i "file.pem" ubuntu@ec2-<ipaddress>.eu-west-1.compute.amazonaws.com
  ```
  Replace <ipaddress> with the actual IP address of your EC2 instance.

- After you are successfully connected, run the following commands to update and upgrade the packages. 
  
    ```
    sudo apt update
    sudo apt upgrade -y
    ```

### Step 3: Setting up Ansible controller (Control Node)

- This step is all about preparing the system to install Ansible by adding the necessary dependicies.

    ```bash

    #Installs the software-properties-common package
    sudo apt install software-properties-common

    #This command adds the Ansible PPA repository to your system
    sudo apt-add-repository ppa:ansible/ansible

    # press enter

    #Updates the package lists
    sudo apt update -y

    #Installs Ansible, an automation tool for configuration management.
    sudo apt install ansible -y

    #Checks the version of Ansible that is installed on your system.
    ansible --version

    #Navigates to the Ansible configuration directory.
    cd /etc/ansible/

    #Installs the tree utility
    sudo apt install tree

    #displays directory in a tree-like format.
    tree 

    #change directory to .ssh
    cd ~/.ssh
    ```

### Step 4: Copying a .pem File from local host to Controller.

- Open a different gitbash terminal on your local machine, now we are going to copy the pem files to our controller instance.By running this command it will securely copy the .pem file to the ~/.ssh directory on our controller instance.
  
    ```bash
    scp -i "~/.ssh/file.pem" ~/.ssh/tech254.pem ubuntu@<ipinstances>:~/.ssh
     ```

    ![Alt text](images/copying_pemkeys_controller.png)

- Now we can go back on our controller instance, and check if the pem file has been copied or not by running `ls' inside ~/.ssh.
  
   ![Alt text](images/copied_key_controller.png)

- Now we need to adjusts the permissions of the pem file on our controller by running the following command, this ensures that the key file is protected and cannot be accessed by others.
  
    ```bash
    sudo chmod 400 tech254.pem
    ```

### Step 5: Create a EC2 Instance (App Instance)

- Create another EC2 instance,this will be our target instance, lets call this instance 
  ansible-app. 
  - Choose the AMI (Amazon Machine Image) and select the community AMI with Ubuntu 20.04 LTS. 
  - Select t2.micro for instance type. 
  - Select the existing key pair that you usually use. This will be used for SSH access.
  - Under network settings, choose an existing security group that allows inbound traffic on ports SSH, HTTP, HTTPS, and port 3000. (create a security group to these ports.)

- Open a Git Bash terminal and use SSH to connect to the ansible-app instance and run the following commands: 

  ```
  sudo apt update

  sudo apt upgrade -y 
  ```

- Finally, lets copy our pem file from local host to our app instance as we did above. 
  
  ![Alt text](images/copying_pemkey_to_app.png)


### Step 6: SSH into Target Instance from Ansible Controller 

- Lets SSH into our app instance (target instance) from our controller. The command below initiates a SSH connection to the target instance ubuntu@[IPaddress] using the private key file 'file.pem' for authentication.

  *Replace [IPaddress] with the actual IP address of your target instance.*

     Input: 
    ```bash
    ssh -i file.pem ubuntu@[privateIPaddress]
    ```

    Output: 

    In order to succesfully test, I have made a text file in my target instance and tested it through my controller. 

    ![Alt text](<images/Screenshot 2023-10-16 165738.png>)
