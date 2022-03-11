public interface IBuscarInformacoesContaService 
{
	List<IContaDomain> obterContasPorCodigosXP(List<String> codigosXP);
	IContaDomain obterContaPorIdChaveExterna(String idChaveExterna);
}