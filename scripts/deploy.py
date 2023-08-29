import boto3

# Get the current running version from ECS
def get_running_task_version(cluster_name, service_name):
    ecs_client = boto3.client('ecs')
    
    try:
        response = ecs_client.describe_services(cluster=cluster_name, services=[service_name])
        running_task_version = response['services'][0]['taskDefinition']
        return running_task_version
    except Exception as e:
        print(f"Error getting running task version: {e}")
        return None

# Deploy new version
def deploy_new_version(cluster_name, service_name, new_task_definition):
    ecs_client = boto3.client('ecs')
    
    try:
        response = ecs_client.update_service(
            cluster=cluster_name,
            service=service_name,
            taskDefinition=new_task_definition
        )
        print("Service update initiated successfully.")
        return response
    except Exception as e:
        print(f"Error updating service: {e}")
        return None

if __name__ == "__main__":
    cluster_name = "my-cluster"
    service_name = "my-ecs-service"
    new_task_definition = "my-task"

    running_task_version = get_running_task_version(cluster_name, service_name)
    
    if running_task_version:
        print(f"Running task version: {running_task_version}")
        print(f"Deploying new task version: {new_task_definition}")
        response = deploy_new_version(cluster_name, service_name, new_task_definition)
        if response:
            print("Deployment initiated successfully.")
    else:
        print("Could not determine running task version.")
