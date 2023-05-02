# BentoDB - Delete Database

A GitHub action to delete a database from [BentoDB](https://bentodb.com).

### Example usage
For a full example see the README.md for the Create Database action: https://github.com/DigitalSVN/bentodb-create-database

```yaml
jobs:
  example_job:
    runs-on: ubuntu-latest
    name: Delete a database using BentoDB
    steps:
      - name: Delete
        id: delete
        uses: DigitalSVN/bentodb-delete-database@main
        with:
          api-token: ${{ secrets.BENTODB_API_TOKEN }}
          database-id: ${{ steps.create.outputs.database_id }}
          
      - name: Confirm deleted database name
        run: echo "Database name - ${{ steps.delete.outputs.database_name }}, ID - ${{ steps.delete.outputs.database_id }}"

```

### Pre-requisites
You will need a BentoDB API token. These are available for FREE at https://www.bentodb.com

### Configuration
| Key           | Example                | Description                                                             | Required |
|---------------|------------------------|-------------------------------------------------------------------------|----------|
| `api-token`   | `AAaaBBbbCCccDDddEEee` | Your BentoDB API token - this should be stored as a secret in your repo | Yes      |
| `database-id` | `12345`                | The ID of the BentoDB database you want to delete                       | Yes      |