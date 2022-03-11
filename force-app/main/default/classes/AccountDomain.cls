public without sharing class AccountDomain implements IAccountDomain, C3C_DI_IProvider
{
    //Exception
    public class AccountDomainException extends Exception {}

    //Atributos
    private AccountMapper AccountMapper {get; set;}

    //Contrutores
    public AccountDomain() 
    {}
    
    private AccountDomain(SObject accountSObject)
    {
        this.construirDomainComSObject(accountSObject);
    }
    
    private AccountDomain(String idRegistro)
    {
        this.construirDomainComIdRegistro(idRegistro);
    }
    
    private AccountDomain(String idRegistro, LeadMapper leadMapper)
    {
        this.construirDomainComBaseNoLeadMapper(idRegistro, leadMapper);
    }

    private AccountDomain(AccountMapper AccountMpp)
    {
        this.AccountMapper = AccountMpp;
    }

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf List<SObject>)
            return this.construirListaDomainComListaSObject((List<SObject>) params);
            
        if(params instanceOf SObject)
            return new AccountDomain((SObject) params);

        if(params instanceOf AccountMapper)
            return new AccountDomain((AccountMapper) params);
        
        if(params instanceOf Map<String,Object>)
        {
            Map<String,Object> mapaParams = (Map<String,Object>) params;
            return new AccountDomain((String) mapaParams.get('idRegistro'), (LeadMapper) mapaParams.get('leadConvertido'));
        }

        return null;
    }
    
    public void atribuirNovoIdDoRegistro()
    {
        this.AccountMapper.idRegistro = this.AccountMapper.record.Id;
    }

    //Responsável por retornar a mapper
    public AccountMapper obterMapper()
    {
        return this.AccountMapper;
    }

    //Responsável por retornar o registro SObject
    public SObject obterRegistro()
    {
        return this.AccountMapper.record;
    }

    //Responsável por construir a domain com sobject
    private void construirDomainComSObject(SObject accountSObject)
    {
        this.AccountMapper = (AccountMapper) C3C_DIContainer_Injector.newInstance('AccountMapper', accountSObject);
    }
    
    //Responsável por construir a domain com idRegistro
    private void construirDomainComIdRegistro(String idRegistro)
    {
        this.AccountMapper = (AccountMapper) C3C_DIContainer_Injector.newInstance('AccountMapper', new Map<String,Object>{
            'idRegistro' => idRegistro
        });
    }

    private void construirDomainComBaseNoLeadMapper(String idRegistro, LeadMapper leadMapper)
    {
        // chamar construirMapaParaContaCPFouCNPJ qndo definir rn
        Map<String,Object> mapaParametrosDaConta = this.construirMapaParaContaCPFouCNPJ(idRegistro, leadMapper);
        this.AccountMapper = (AccountMapper) C3C_DIContainer_Injector.newInstance('AccountMapper', mapaParametrosDaConta);
    }
    
    //Responsável por construir uma lista de domain com uma lista de sobject
    private List<AccountDomain> construirListaDomainComListaSObject(List<SObject> listaAccountsSObject)
    {
        List<AccountDomain> listaDeAccountsDomain = new List<AccountDomain>();

        for(SObject AccountSObject : listaAccountsSObject)
            listaDeAccountsDomain.add(new AccountDomain(AccountSObject));

        return listaDeAccountsDomain;
    }

    public AccountMapper modificarNomeDaConta(String novoNome)
    {
        this.obterMapper().nomeDaConta = novoNome;
        return this.obterMapper();
    }

    private Map<String,Object> construirMapaParaContaCPFouCNPJ(String idRegistro,LeadMapper leadMapper)
    {
        Map<String,Object> mapaParametrosDaConta = new Map<String,Object>{
            'idRegistro' => idRegistro,
            'nomeConta' => leadMapper.nome +' '+leadMapper.sobrenome
        };

        try 
        {
            if(!String.isBlank(leadMapper.cpf) && !String.isBlank(leadMapper.cnpj)) 
            {
                throw new AccountDomainException('Conta com cpf e cnpj preenchido.');
            }
            else if(leadMapper.cpf != '' && leadMapper.cpf != null)
            {
                mapaParametrosDaConta.put('idChaveExterna', leadMapper.cpf);
            }
            else if(leadMapper.cnpj != '' && leadMapper.cnpj != null)
            {
                mapaParametrosDaConta.put('idChaveExterna', leadMapper.cnpj);
            }
            else 
            {
                throw new AccountDomainException('Não é possível gerar a conta pois o lead convertido não tem cpf nem cnpj.');
            }
            
        } catch (Exception e) 
        {
            System.debug(e.getMessage());
        }
        return mapaParametrosDaConta;

    }

}