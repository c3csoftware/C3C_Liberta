public interface IInstanciaRespostaDomain 
{
	InstanciaRespostaMapper obterMapper();
    SObject obterRegistro();
    void atribuirNovoIdDoRegistro();
}