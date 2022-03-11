public interface IGroupSelector 
{
    SObject obterGroupPorNome(String nome);
    List<SObject> obterGroupPorNomes(Set<String> nomes);
    List<SObject> buscarGroupPorPapelRelacionado(Set<String> idsPapel);
    List<SObject> buscarGroupPorInicioTag(String tag);
}