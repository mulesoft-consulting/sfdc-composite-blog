%dw 2.0
output application/java 

fun split
(text) = text splitBy(" ")

fun mapAccount(account) = {
	"attributes": {
		"type": "Account",
		"referenceId": account.accountNumber
	},
	"name": account.name,
	"website": account.website,
	"numberOfEmployees": account.numberOfEmployees as Number,
	"active__c" : account.active,
	"sla__c": account.sla,
	"acctNumber__c": account.accountNumber,
	"phone": account.phone,
 	(if(account.contacts != null) {"Contacts": {
		"records": mapContacts(account.contacts)
	    }
	} else {}
	),
	
    (if(mapChildAccounts(account.childAccounts) != null) 
    {
        "childAccounts": {
            "records": mapChildAccounts(account.childAccounts)
    }
    }	
    else
    {})
}

fun mapChildAccounts(childAccounts) = childAccounts map (account, index) ->
		mapAccount(account) 

fun mapContacts(contacts) = contacts map (contact, index) ->{
			"attributes": {
				"type": "Contact",
				"referenceId": contact.email
			},
			"department": contact.department,
			"email": contact.email,
			"firstname": split(contact.name)[0],
			"lastname": split(contact.name)[1],
			"phone": contact.phone,
			"title": contact.title
		}
---
[
	mapAccount(payload) 
	
]