---
name: shopping-list-manager
description: Manages a persistent shopping list with proximity-based sorting based on user checkout patterns.
---

# Shopping List Manager

This skill manages a persistent shopping list stored in `/data/shopping_list.json`. It uses specific trigger phrases to add, retrieve, and manage items.

## Storage Format
The data is stored in `/data/shopping_list.json` as:
```json
{
  "items": [
    {"name": "servilletas", "status": "pending", "added_at": "timestamp"},
    {"name": "trash bags", "status": "completed", "added_at": "timestamp"}
  ],
  "preferred_order": ["servilletas", "trash bags", "milk"]
}
```

## Workflows

### 1. Adding Items
- **Trigger**: Messages starting with "faltan " (e.g., "faltan servilletas de cocina").
- **Action**: 
  1. Extract the item name.
  2. Read existing JSON using `read_file`.
  3. Append to `items` list with `status: "pending"`.
  4. Write back using `write_file`.
  5. Confirm addition.

### 2. Retrieving the List (Shopping Mode)
- **Trigger**: Messages like "estoy en el super" or similar.
- **Action**:
  1. Read `items` from file.
  2. Filter for `status: "pending"`.
  3. Sort the pending items based on the `preferred_order` list. Items not in `preferred_order` come last.
  4. Return a numbered list (1. Item A, 2. Item B...).
  5. Enter "Shopping Mode" (internally track that the user is currently crossing off items).

## Workflows

### 3. Crossing Off Items
- **Trigger**: A numeric input (e.g., "1", "2, 5") while in Shopping Mode.
- **Action**:
  1. Read existing JSON using `read_file`.
  2. Match number to the list provided in the previous step.
  3. Update those items to `status: "completed"`.
  4. **Proximity Learning**: Update `preferred_order`. 
     - If items are crossed off in a sequence (e.g., 2 then 5 then 1), update `preferred_order` so that these items appear in this relative order for future trips.
  5. Write back using `write_file`.
  6. Confirm crossing off.

### 4. Checking Missing Items
- **Trigger**: "dime que falta".
- **Action**:
  1. Read `items` from file.
  2. Filter for `status: "pending"`.
  3. Return the list of remaining items.

## Pitfalls
- **Ambiguous Numbers**: Ensure the numbering is consistent with the list just sent.
- **State Persistence**: Always read/write to the JSON file to avoid losing data between session turns.
- **Tooling Restrictions**: If `execute_code` is blocked or unavailable for JSON manipulation, use `read_file` to ingest the JSON string, perform the update in-memory, and `write_file` to save the result.
- **Language**: The triggers are in Spanish, but the logic applies to any language items are added in.
