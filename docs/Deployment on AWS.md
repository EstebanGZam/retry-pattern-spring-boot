# Deploying Spring Boot Services on AWS Elastic Beanstalk

## **Prerequisites**

1. **Create a Free AWS Account**
2. **Install AWS CLI**
3. **Prepare the `.jar` Files**

## **Step-by-Step Deployment Guide**

### **1. Creating an AWS Account**

- Visit [AWS](https://aws.amazon.com/)
- Click on "Create an AWS Account"
- Follow the registration steps (requiring a credit card, phone number, and email)
- AWS provides a free-tier for 12 months, sufficient for this deployment.
  ![Image](ANNEXES/Pasted%20image%2020250305062759.png)
  
- Once registration is complete:  
  
  ![Image](ANNEXES/Pasted%20image%2020250304230850.png)

### **2. Installing AWS CLI**

```bash
# Ubuntu/Debian installation
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Configure AWS credentials
aws configure
# Required inputs:
# AWS Access Key ID
# AWS Secret Access Key
# Default region name (e.g., us-east-1)
# Default output format (e.g., json)
```

### **3. Configuring AWS CLI Credentials**

1. **Log in to AWS Console** ([AWS Console](https://console.aws.amazon.com/))
2. **Create an IAM User**
    - Navigate to `Services > IAM`
    - Select "Users" > "Add users"
    - Provide a username
    - Choose "Provide user access to the AWS Management Console"
    - Assign **Administrator** permissions for simplified deployment
    - Create the user ![Image](ANNEXES/Pasted%20image%2020250304230841.png)
3. **Generate Access Credentials**
    - Go to "Security Credentials" tab
    - Click "Create access key"
    - Choose "Command Line Interface (CLI)" ![Image](ANNEXES/Pasted%20image%2020250304230833.png)
    - Confirm and download the `.csv` file containing credentials
4. **Enter Credentials in AWS CLI**
    - Retrieve the `Access Key ID` and `Secret Access Key` from the `.csv` file
    - Default region: Typically `us-east-1` (verify via AWS Console URL)
    - Default output format: `json`

Example:
![Image](ANNEXES/Pasted%20image%2020250304231022.png)

```bash
aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-east-1
Default output format [None]: json
```


**Security Recommendations:**

- Store credentials securely
- Do not share the `.csv` file
- Regenerate keys if necessary

---

### **4. Installing Elastic Beanstalk CLI**

#### **Requirements**

- AWS CLI configured (`aws configure` completed)
- Python3 and `pip` installed

#### **Installation (Recommended Method)**

```bash
# Ensure pip is installed
sudo apt update
sudo apt install python3-pip

# Install Elastic Beanstalk CLI
pip3 install awsebcli --break-system-packages
```

#### **Verify Installation**

```bash
# Check AWS CLI version
aws --version

# Check Elastic Beanstalk CLI version
eb --version
```

### **5. Assigning IAM Permissions for Elastic Beanstalk**

To deploy applications using Elastic Beanstalk, the IAM user must have appropriate permissions:

1. Navigate to `IAM > Users`
2. Select the IAM user
3. Click "Add permissions" > "Create inline policy"
4. Switch to the **JSON** editor and paste:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:*",
                "ec2:*",
                "elasticloadbalancing:*",
                "cloudformation:*",
                "elasticbeanstalk:*",
                "iam:*",
                "logs:*",
                "s3:*"
            ],
            "Resource": "*"
        }
    ]
}
```

![Image](ANNEXES/Pasted%20image%2020250305054145.png)

5. Click "Review policy", name it (e.g., `AWSElasticBeanstalkFullAccess`), and create it.
6. Attach the policy to the IAM user.

![Image](ANNEXES/Pasted%20image%2020250305054103.png)

---

### **6. Deploying the `address-service`**

> **Note:** The following procedure must first be performed with the `address-service`, as the order service depends on it. It is necessary to obtain the URL of the `address-service` to determine where the order service will make its requests. It is recommended to read the section below to understand what the following commands do.

```bash
cd address-service/
echo "web: java -jar target/address-service-0.0.1-SNAPSHOT.jar" > Procfile

# Build the executable
mvn clean package

# Initialize Elastic Beanstalk application
eb init

# Create the Elastic Beanstalk environment
eb create address-service-env

# Deploy `address-service`
eb use address-service-env
eb deploy
```

Deployment confirmation: ![Image](ANNEXES/Pasted%20image%2020250305050852.png)

> The `address-service` runs on port **5000**.

---

### **7. Deploying the `order-service`**

#### **Define Execution Process (`Procfile`)**

```bash
echo "web: java -jar target/order-service-0.0.1-SNAPSHOT.jar" > Procfile
```

#### **Build the Application**

```bash
mvn clean package
```

![Image](ANNEXES/Pasted%20image%2020250305051405.png)

#### **Initialize Elastic Beanstalk Application**

```bash
eb init
```

**Configuration:**

- AWS Region: `us-east-1`
- Create a new application: `order-service`
- Platform: `Java`
- Runtime: `Corretto 17 on Amazon Linux 2`
- No Docker or SSH configuration

#### **Create the Environment**

```bash
eb create order-service-env
```

#### **Deploy `order-service`**

```bash
eb use order-service-env
eb deploy
```

#### **Retrieve the Service URL**

To obtain the running service URL, use:

```bash
eb status
```

Example output:
![Image](ANNEXES/Pasted%20image%2020250305054641.png)

In the output of the command, look for a line that says:

```
CNAME: order-service-env.eba-fpzbrk9v.us-east-1.elasticbeanstalk.com
```
This is the link where the service is available.

---

### **8. Demonstrating Functionality**

#### **`address-service` Running:**

![Image](ANNEXES/Pasted%20image%2020250305070513.png)

#### **`order-service` Running:**

![Image](ANNEXES/Pasted%20image%2020250305070535.png)

