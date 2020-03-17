public class AccToDisp {
    public List<Contact> ContList{get;set;}
    
    public class WrapTODis
    {
        
    }
    
    Public List<WrapToDis> fullRow {get;set;}     


public AccToDisp()
{
    ContList=[select FirstName,LastName,Email,Updated__c from Contact limit 10];
    
}
    

}