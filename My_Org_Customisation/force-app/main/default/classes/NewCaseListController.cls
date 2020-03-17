public class NewCaseListController {
    
    private String status_case='New';
    
    public List<case> getNewCases()
    {
        List<case> results=database.query('Select id, CaseNumber from Case where Status='+'\''+status_case+'\'');
        return results;
        
    }

}