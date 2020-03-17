public class ContToDisp {  
    Public List<WrapToDis> fullRow {get;set;}    
    Public List<WrapToDis> selectedRow {get;set;}    
    public Boolean selectAll{get;set;}
    private integer counter;  
    public integer list_size {get;set;}
    public Boolean atleastOne{get;set;}
    public date chooseDate{get;set;}
    public List<SelectOption> optionsAvailable {get;set;} 	
    public Integer total_size {get; set;}
    public Boolean disabledPrevious{get;set;}
    public Boolean disabledNext{get;set;}
    public integer pageNumber{get;set;}
    public String valueofPage{get;set;}
    
    public class WrapTODis
    {
        public Contact invCont {get;set;}
        public integer Sno {get; set;}       
        public  Boolean isSelected{get;set;} 
       
       public WrapTODis(Contact a, integer b)
       {    
           invCont=a;
           isSelected=false;
           Sno=b;  
       }   
    }
    
    
    public void allSelect()
    {
      
        if(selectAll==true)
        {
        
            for(WrapToDis a:fullRow)
            {
                a.isSelected=true;
            }
            atleastOne=true;
        }
        else
        {
            for(WrapToDis a:fullRow)
            {
                a.isSelected=false;
            }
            atleastOne=false;
        }
        if(atleastOne==false)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.INFO,'Please select atleast one contact'));
        }
    }  
    
    
    public void checkAll()
    {      
         atleastOne=false;
       for (WrapToDis a:fullRow)
       {	
           if(a.isSelected==false)
           {
               selectAll=false;
           }
            else                
           {
               atleastOne=true;
              // selectAll=false;
               selectedRow.add(a);
              
           }
          }
        if(atleastOne==false)
        {      
            ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.INFO,'Please select atleast one contact'));
        }
       } 
    
    
    Public void Next(){ 
        disabledPrevious=false;
        fullRow.clear();
        counter += list_size;
        integer rowNum=counter+1;
        pageNumber=(counter/list_size)+1;
       List<Contact> ContList = new List <Contact>([select FirstName,LastName,Email,Updated__c from Contact order by FirstName  limit :list_size offset :counter ]);
     for(Contact a:ContList)
     {
        FullRow.add(new WrapTODis(a,rowNum));
        rowNum++;     
       }   
    }
    

    
    
    
    Public void Beginning()
    {
         counter = 0;
        pageNumber=(counter/list_size)+1;
       
        fullRow.clear();
        integer rowNum=counter+1;
          try {   
   List<Contact> ContList = new List <Contact>([select FirstName,LastName,Email,Updated__c from Contact order by FirstName  limit :list_size offset :counter ]); 
     for(Contact a:ContList)
     {
        FullRow.add(new WrapTODis(a,rowNum));
        rowNum++;     
       } 
      }
        catch (QueryException e) {
    ApexPages.addMessages(e);  
    } 
        disabledPrevious=true;
    }
    
    
      Public void Previous()
    { 
        pageNumber=(counter/list_size);
        counter -= list_size;
        fullRow.clear();
      integer rowNum=counter+1;
       
          try {   
   List<Contact> ContList = new List <Contact>([select FirstName,LastName,Email,Updated__c from Contact order by FirstName  limit :list_size offset :counter ]); 
     for(Contact a:ContList)
     {
        FullRow.add(new WrapTODis(a,rowNum));
        rowNum++;     
       } 
      }
        catch (QueryException e) {
    ApexPages.addMessages(e);  
    } 
        if(pageNumber==1)
        {
            disabledPrevious=true;
        }
    }
    
    
      Public void End()
    {
        counter = total_size - math.mod(total_size, list_size);
        integer rowNum=counter;
         pageNumber=(counter/list_size);
        fullRow.clear();
        
          try {   
   List<Contact> ContList = new List <Contact>([select FirstName,LastName,Email,Updated__c from Contact order by FirstName  limit :list_size offset :counter ]); 
     for(Contact a:ContList)
     {
        FullRow.add(new WrapTODis(a,rowNum));
        rowNum++;     
       } 
      }
        catch (QueryException e) {
    ApexPages.addMessages(e);  
    }
        disabledNext=true;
    }
    
    

     public ContToDisp()
   {
     fullRow=new List<WrapToDis>();
       selectedRow =new List<WrapToDis>();
       counter=0;
       pageNumber=1;
       list_size=10;
     selectAll=false;
     atleastOne=false;
       disabledPrevious=true;
       chooseDate=date.today();
     integer rowNum=counter+1;
        if(atleastOne==false)
        {   
            ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.INFO,'Please select atleast one contact'));
        }
       optionsAvailable= new List<SelectOption>();
       optionsAvailable.add(new SelectOption('invalidO','Choose an Option'));
       optionsAvailable.add(new SelectOption('logacall','Log an Call'));
       optionsAvailable.add(new SelectOption('createContact','Create Contact'));
       total_size = [select count() from Contact];
     List<Contact> ContList = new List <Contact>([select FirstName,LastName,Email,Updated__c from Contact order by FirstName  limit 10 offset 0 ]); 
     for(Contact a:ContList)
     {
        fullRow.add(new WrapTODis(a,rowNum));
        rowNum++;     
       }  
    }
  }