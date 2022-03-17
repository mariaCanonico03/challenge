({
    doinit : function(cmp, event, helper) {
        var recordId = cmp.get("v.recordId");
        console.log('recordId init'+recordId);
        var getAdjustments = cmp.get("c.getAdjustments");
        getAdjustments.setParam("caseId", recordId);
        cmp.set('v.mycolumns', [
            { label: 'adjustmentId', fieldName: 'adjustmentId', type: 'text'},
            {label: 'status', fieldName: 'status',type: 'text'}
        ]);

        getAdjustments.setCallback(this, function (response) {
            console.log('return call back ');
            var message = response.getReturnValue();
            var messageParsed = JSON.parse(message);
            console.log('adjustments '+message);
            console.log('adjustments messageParsed '+messageParsed);
            cmp.set('v.adjustments', messageParsed);
            cmp.set('v.mydata', messageParsed.adjustments);
            console.log('adjustments '+message);
            console.log('adjustments messageParsed '+messageParsed);
        });
        $A.enqueueAction(getAdjustments);
    },
    callCreateAdjustment : function(cmp, event, helper) {
        var recordId = cmp.get("v.recordId");
        console.log('recordId '+recordId);
        var createAdjustment = cmp.get("c.createAdjustment");
        var amount = cmp.get('v.amount');
        createAdjustment.setParam("caseId", recordId);
        createAdjustment.setParam("amount", amount);
        createAdjustment.setCallback(this, function (response) {
            var message = response.getReturnValue();
            var messageParsed = JSON.parse(message);
            cmp.set('v.showAdj', true);
            cmp.set('v.amountReturned', amount);
            cmp.set('v.amount', '');
            cmp.set('v.adjId', messageParsed.adjustmentId);
            cmp.set('v.adjStatus',messageParsed.status);
        });
        $A.enqueueAction(createAdjustment);
    }
})
