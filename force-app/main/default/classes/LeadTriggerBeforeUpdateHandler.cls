public without sharing class LeadTriggerBeforeUpdateHandler extends TriggerHandlerBase
{
    public class LeadTriggerBeforeUpdateHandlerException extends Exception{}

    //Construtores
    public LeadTriggerBeforeUpdateHandler() {}

    //Métodos
    public override void mainEntry(TriggerParameters tp) 
    {
        List<ILeadDomain> listaLeadDomain = (List<ILeadDomain>) C3C_DIContainer_Injector.newInstance('LeadDomain',(List<SObject>) tp.newList);
        
        this.leadTriggerBeforeUpdateServiceInstance.atualizarLeads(listaLeadDomain);
        
        this.tratativaDeCampoLeadServiceInstance.tratarCpfCnpj(listaLeadDomain);
    }
    
    public override void inProgressEntry(TriggerParameters tp) {}
    
    public override void updateObjects() {}

    //Atributos de serviço
    private ILeadTriggerBeforeUpdateService leadTriggerBeforeUpdateServiceInstance
    {
        get
        {
            if(this.leadTriggerBeforeUpdateServiceInstance == null)
                this.leadTriggerBeforeUpdateServiceInstance = (ILeadTriggerBeforeUpdateService) C3C_DIContainer_Injector.getInstance('LeadTriggerBeforeUpdateService');

            return this.leadTriggerBeforeUpdateServiceInstance;
        }
        set;
    }

    private ITratativaDeCampoLeadService tratativaDeCampoLeadServiceInstance
    {
        get
        {
            if(this.tratativaDeCampoLeadServiceInstance == null)
                this.tratativaDeCampoLeadServiceInstance = (ITratativaDeCampoLeadService) C3C_DIContainer_Injector.getInstance('TratativaDeCampoLeadService');

            return this.tratativaDeCampoLeadServiceInstance;
        }
        set;
    }
}