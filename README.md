Assunptions 
- Response errors have not been handled by assuming that api always reply with code 200.

**Get Account Transactions:**
It has been created an aura component called showAccountFromExternalSystem and added to the Account Page Layout. It shows all the transactions releted with the Account.
Of course the number of transactions are static because the response is hardcoded.

**Post an adjustment on the current account:**
A component has been created in the Case object and it allows to create an adjustment by inserting the amount. When the "Create Adjustment" button is pressed on the right it will appear the adjstments already created with its particular status.
For the part of the requirment where it says "Then create an adjustment below 1000€ which automatically is
being displayed in customer’s transactions" I supposed that in the external system this adjustment will be automatically be available so when the User go in the Transactions component it will shows automatically because it makes the getTransactions call (of course it doesn't work because the response is hardcoded)

**Display adjustment on the current account:**
I found this requirment a bit confusing because of the definition of adjustment. Each adjustment has an AdjustmentId but in the getAdjustments request it is necessary to specify the adjustmentId and in the response we will have the list of adjustments. I moked the getAdjustments call and create a table (with fixed response).

**Make the adjustment effective**
I left this requirment blank because it had to little requirment. For what I understood it would be necessary to create a button where a user could change the the status (only in Salesforce to "PENDING_ACCEPTED") and be approved by another user and when it is approved send a patch call to the external system.
But here we could have a problem because of the impossibility to save information in Salesforce.

**Requirements 2**
Also this requirment is a bit confusing.
If it is true that Customer blocks cannot be saved in Salesforce, what we can do is allow to create or update a Customer block and send the information to the External system: one call for each insert/update of the block.

If instead we can save Customer blocks in Salesforce and it is necessary to synchronize the information it is necessary to know:
1. Customer blocks can be modified only in Salesforce or also in the external System?
2. Do we need to synchronize both ways?
3. It is important to have informations updated in near real time?

So if we can save information in Salesforce the idea is to create a scheduled batch to send the updates to the external system. 
