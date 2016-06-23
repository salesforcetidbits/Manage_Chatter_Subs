public class FollowPanelController {

	public String activeTab {get;set;}
	public Map<String, List<ChatterSubsctiption>> subscriptions;
	public String deleteId {get;set;}

	public FollowPanelController(){
		activeTab = 'Chatter';
	}

	public Map<String, List<ChatterSubsctiption>> getSubscriptions(){

		subscriptions = new Map<String, List<ChatterSubsctiption>>();

		for(Entitysubscription ent :[select Id, ParentId, SubscriberId, CreatedDate from Entitysubscription where SubscriberId =:UserInfo.getUserId()]){

			ChatterSubsctiption tmp = new ChatterSubsctiption(ent);

			if(subscriptions.containsKey(tmp.sObjectName)){
				subscriptions.get(tmp.sObjectName).add(tmp);
			}
			else if(!String.valueOf(tmp.sObjectName).containsIgnoreCase('__c')){
				List<ChatterSubsctiption> tmpList = new List<ChatterSubsctiption>{tmp};
				subscriptions.put(tmp.sObjectName, tmpList);
			}
		}

		return subscriptions;
	}

	public Pagereference doDelete(){
		delete new Entitysubscription(id=deleteId);
		return null;
	}
}