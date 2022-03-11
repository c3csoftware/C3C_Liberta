public interface IProdutoDomain 
{
    ProdutoMapper construirProdutoMapper(SObject produto);
    List<ProdutoMapper> construirListProdutoMapper(List<SObject> listProduto);
}