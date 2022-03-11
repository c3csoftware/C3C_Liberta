@isTest
public class AdicionaListaLeadFilhoServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('LeadService', Test.createStub(LeadService.class, new LeadServiceStub()));
        C3C_DIContainer_Injector.createInstance('ContatoActiveRestService', Test.createStub(ContatoActiveRestService.class, new ContatoActiveRestServiceStub()));
    }

	@isTest
    static void testCoverage()
    {
        AdicionaListaLeadFilhoService.testCoverage();
    } 

    public class ContatoActiveRestServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'ContatoActiveRestService';
        }

        public override Map<String,ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

    public class LeadServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadService';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }
}