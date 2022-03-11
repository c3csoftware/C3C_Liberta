@isTest
public class LeadSelectorTest 
{
	public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();
    
    static void setupInjector()
    {
		C3C_DIContainer_Injector.createInstance('C3C_Lib_Database', Test.createStub(C3C_Lib_IDatabase.class, new C3C_Lib_DatabaseStub()));
    }
    
    @isTest
    public static void testObterLeadPorActiveCampaignId()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        SObject listObjLead = new LeadSelector().obterLeadPorActiveCampaignId('recordId');
        
        //THEN
        System.assertEquals(new Lead(), listObjLead, 'O método deveria retorna "Lead{}".');
    }

    @isTest
    public static void testBuscarLeadComNumeroCelular()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        SObject listObjLead = new LeadSelector().buscarLeadComNumeroCelular('numeroCelular');
        
        //THEN
        System.assertEquals(new Lead(), listObjLead, 'O método deveria retorna "Lead{}".');
    }

    @isTest
    public static void testObterLeadPorIdsDoLead()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        List<SObject> listObjLead = new LeadSelector().obterLeadPorIdsDoLead(new List<String>());
    }
    
        @isTest
    public static void testObterLeadComStatusNovoPorIdsDoLead()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        List<SObject> listObjLead = new LeadSelector().obterLeadComStatusNovoPorIdsDoLead(new List<String>());
    }
    
            @isTest
    public static void testobterLeadPorIdDoLead()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        new LeadSelector().obterLeadPorIdDoLead('');
    }
    
    public class C3C_Lib_DatabaseStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'C3C_Lib_Database';
        }
    
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
        
        public override Object methodCall(
            Object stubbedObject, 
            String stubbedMethodName,
            Type returnType, 
            List<System.Type> listOfParamTypes, 
            List<String> listOfParamNames,
            List<Object> listOfArgs
        )
        {
            Object returnValue;
            
            
            switch on stubbedMethodName
            {
                when 'queryExecute'
                {
                    returnValue = new List<SObject>{Schema.getGlobalDescribe().get('Lead').newSObject()}; 
                }
            }
            
            return returnValue;
        }
    }
    
    
}