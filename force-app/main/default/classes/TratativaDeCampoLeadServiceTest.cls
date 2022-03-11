@isTest
public with sharing class TratativaDeCampoLeadServiceTest 
{
    @isTest
    static void testCoverage()
    {
        TratativaDeCampoLeadService.testCoverage();
    } 

    @isTest 
    static void testeTratarCpfCnpjPassandoCpfMascarado()
    {
        ILeadDomain leadDomain = (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain', Schema.getGlobalDescribe().get('Lead').newSObject());
        leadDomain.obterMapper().validadorDocumento = '707.172.100-90';
        new TratativaDeCampoLeadService().tratarCpfCnpj(new List<ILeadDomain>{
            leadDomain
        });
    }

    @isTest 
    static void testeTratarCpfCnpjPassandoCpfSemMascara()
    {
        ILeadDomain leadDomain = (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain', Schema.getGlobalDescribe().get('Lead').newSObject());
        leadDomain.obterMapper().validadorDocumento = '70717210090';
        new TratativaDeCampoLeadService().tratarCpfCnpj(new List<ILeadDomain>{
            leadDomain
        });
    }

    @isTest 
    static void testeTratarCpfCnpjPassandoCnpjMascarado()
    {
        ILeadDomain leadDomain = (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain', Schema.getGlobalDescribe().get('Lead').newSObject());
        leadDomain.obterMapper().validadorDocumento = '99.644.259/0001-32';
        new TratativaDeCampoLeadService().tratarCpfCnpj(new List<ILeadDomain>{
            leadDomain
        });
    }

    @isTest 
    static void testeTratarCpfCnpjPassandoCnpjSemMascara()
    {
        ILeadDomain leadDomain = (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain', Schema.getGlobalDescribe().get('Lead').newSObject());
        leadDomain.obterMapper().validadorDocumento = '99644259000132';
        new TratativaDeCampoLeadService().tratarCpfCnpj(new List<ILeadDomain>{
            leadDomain
        });
    }

    @isTest 
    static void testeTratarCpfCnpjPassandoQualquerCoisa()
    {
        ILeadDomain leadDomain = (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain', Schema.getGlobalDescribe().get('Lead').newSObject());
        leadDomain.obterMapper().validadorDocumento = '9964425';
        new TratativaDeCampoLeadService().tratarCpfCnpj(new List<ILeadDomain>{
            leadDomain
        });
    }
}