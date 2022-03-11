public class C3C_Lib_Database implements C3C_Lib_IDatabase
{   
    public List<SObject> queryExecute(String query)
    {
        List<SObject> listResult = (List<SObject>) Database.query(query);
        
        return (List<SObject>) this.decoupleFromQuery(listResult);
    }

    public List<SObject> queryExecute(fflib_QueryFactory query)
    {
        List<SObject> listResult = (List<SObject>) Database.query(query.toSOQL());
        if(listResult.size() > 0 && !C3C_APP_ApplicationContext.contract.mapPagination.containsKey(query.pageNumber+1))
        {
        	C3C_APP_ApplicationContext.addNewReferencePagination(listResult[listResult.size()-1].get(query.pageReferenceField));
        }
        
        return (List<SObject>) listResult;
    }

    private List<SObject> decoupleFromQuery(List<SObject> listObjects)
    {
        return (List<SObject>) JSON.deserialize(JSON.serialize(listObjects), List<SObject>.class);
    }
}