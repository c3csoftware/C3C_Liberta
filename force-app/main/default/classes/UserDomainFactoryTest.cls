@isTest
public with sharing class UserDomainFactoryTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('UserDomain', UserDomain.class, 'UserDomainFactoryTest.UserDomainStub');
        C3C_DIContainer_Injector.createInstance('UserSelector', UserDomain.class, 'UserDomainFactoryTest.UserSelectorStub');
    }

    @isTest 
    static void testeConstruirListaUserDomainAPartirListaSobject()
    {
        setupInjector();

        UserDomainFactory.construirListaUserDomainAPartirListaSobject(new List<SObject>{
            Schema.getGlobalDescribe().get('User').newSObject()
        });
    } 

    @isTest 
    static void testeConstruirMapUserDomainAPartirListaSobject()
    {
        setupInjector();
        UserSelector userSelector = new UserSelector();

        UserDomainFactory.construirMapUserDomainAPartirListaSobject(
            userSelector.obterUsuariosPorCodigoAssessor(new List<String>{'4013'})
        );
    } 

    public class UserDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'UserDomain';
        }
    
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

    public class UserSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'UserSelector';
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
                when 'obterUsuariosPorCodigoAssessor'
                {
                    returnValue = new List<User>{new User(Username = 'Test@test.com', CodigoAssessor__c = 4013)};
                }
            }
            
            return returnValue;
        }
    }
}