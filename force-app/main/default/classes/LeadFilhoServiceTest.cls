@isTest
public class LeadFilhoServiceTest 
{
	public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();
    
    @isTest
    static void testCoverage()
    {
        LeadFilhoService.testCoverage();
    } 

    static void setupInjector()
    {
		C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_ISObjectUnitOfWork.class, 'LeadFilhoServiceTest.fflib_SObjectUnitOfWorkStub');
        C3C_DIContainer_Injector.createInstance('List<String>', List<String>.class, 'LeadFilhoServiceTest.ListStringStub');
    }
    
    public class fflib_SObjectUnitOfWorkStub extends C3C_AbstractStub implements System.StubProvider
    {        
        public override String getClassName()
        {
            return 'fflib_SObjectUnitOfWork';
        }
    
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }
    
    public class ListStringStub extends C3C_AbstractStub implements System.StubProvider
    {     
        public override String getClassName()
        {
            return 'List<String>';
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
                when 'contains'
                {
                    returnValue = false;
                }

                when 'add'
                {
                    returnValue = 'tste';
                }
            }
            
            return returnValue;
        }
    }
}