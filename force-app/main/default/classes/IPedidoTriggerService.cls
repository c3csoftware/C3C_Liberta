public interface IPedidoTriggerService 
{
    void vincularPedidosAsContas(List<PedidoDomain> listaPedidoDomain);
    void criarContasParaPedidos(List<PedidoDomain> listaPedidoDomain);
}