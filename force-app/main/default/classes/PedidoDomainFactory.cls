public without sharing virtual class PedidoDomainFactory 
{
    /**
     * Método responsável por transformar uma lista de SObject em Lista de 
     * PedidoDomain.
     * =================
     * @param Lista de SObject
     * @return Lista de PedidoDomain
     */
    public static List<PedidoDomain> construirListaPedidoDomainAPartirListaSobject(List<SObject> listaPedidoSObject)
    {
        List<PedidoDomain> listaPedidoDomain = new List<PedidoDomain>();

        for (SObject pedidoSObject : listaPedidoSObject)
        {
            listaPedidoDomain.add((PedidoDomain) C3C_DIContainer_Injector.newInstance('PedidoDomain', pedidoSObject));
        }
        
        return listaPedidoDomain;
    }
}