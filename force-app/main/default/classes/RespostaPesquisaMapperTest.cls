@isTest
public class RespostaPesquisaMapperTest 
{
	@isTest
    static void testeNewInstance() 
    {
        RespostaPesquisaMapper respostaPesquisaMapper = (RespostaPesquisaMapper) new RespostaPesquisaMapper().newInstance(Schema.getGlobalDescribe().get(new RespostaPesquisaMapper().getObjectName()).newSObject());
        
        System.assert(respostaPesquisaMapper != null, 'O retorno do método deveria ser diferente de null');
    }
    
    @isTest
    static void testeNewInstanceMapa() 
    {
        RespostaPesquisaMapper respostaPesquisaMapper = (RespostaPesquisaMapper) new RespostaPesquisaMapper().newInstance(new Map<String, Object>{
            'codigoCliente' => 'Código Cliente',
            'nota' => 'Nota',
            'entidadePesquisa' => 'Entidade Pesquisa',
            'nomeCliente' => 'Nome do Cliente'
        });
        
        System.assert(respostaPesquisaMapper != null, 'O retorno do método deveria ser diferente de null');
    }
    
    @isTest
    static void testeNewInstanceNull() 
    {
        RespostaPesquisaMapper respostaPesquisaMapper = (RespostaPesquisaMapper) new RespostaPesquisaMapper().newInstance('Tiago');
        
        System.assert(respostaPesquisaMapper == null, 'O retorno do método deveria ser igual à null');
    }
}