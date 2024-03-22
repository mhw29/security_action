from jira import JIRA
import argparse
import json

# Set up argument parser
parser = argparse.ArgumentParser(description="Create JIRA issues from SARIF file.")
parser.add_argument("--jira_url", required=True, help="JIRA instance URL")
parser.add_argument("--jira_username", required=True, help="JIRA username")
parser.add_argument("--jira_token", required=True, help="JIRA API token")
parser.add_argument("--project_key", required=True, help="JIRA project key")
parser.add_argument("--sarif_file", required=True, help="Path to the SARIF file")

# Parse arguments
args = parser.parse_args()

# Access arguments
jira_url = args.jira_url
jira_username = args.jira_username
jira_token = args.jira_token
project_key = args.project_key
sarif_file = args.sarif_file
issue_type = "Bug"

# Initialize JIRA client
jira = JIRA(basic_auth=(jira_username, jira_token), options={"server": jira_url})


# Function to check for existing issues with the same summary
def issue_exists(summary):
    query = f'project = "{project_key}" AND summary ~ "\\\\"{summary}"\\\\"'
    issues = jira.search_issues(query)
    return len(issues) > 0

# Function to create a JIRA issue for each finding, if it doesn't already exist
def create_jira_issue(finding):
    summary = finding["shortDescription"]["text"]
    description = finding.get("help", {}).get("markdown", "")

    if issue_exists(summary):
        print(f"An issue with summary '{summary}' already exists. Skipping.")
        return

    issue_dict = {
        "project": {"key": project_key},
        "summary": summary,
        "description": description,
        "issuetype": {"name": issue_type},
    }
    new_issue = jira.create_issue(fields=issue_dict)
    print(f"Issue {new_issue} created for {summary}")

# Load SARIF file
with open(sarif_file, "r") as file:
    sarif_data = json.load(file)

for run in sarif_data.get("runs", []):
    for result in run.get("results", []):
        rule_id = result.get("ruleId")
        rule = next((rule for rule in run["tool"]["driver"]["rules"] if rule["id"] == rule_id), None)
        if rule:
            create_jira_issue(rule)
