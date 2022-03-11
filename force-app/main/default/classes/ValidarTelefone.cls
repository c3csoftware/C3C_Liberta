public class ValidarTelefone 
{
    public class BotOutput 
 	{
    	@InvocableVariable(required=true)
    	public Boolean validacaoTelefone;
  	}

  	public class BotInput 
  	{
    	@InvocableVariable(required=true)
    	public String telefoneInput; 
  	}

    @InvocableMethod(label='Validar Telefone')
    public static List<BotOutput> retornarTelefoneValido(List<BotInput> botInputs) 
    {
        List<BotOutput> botOutputReturn = new List<BotOutput>();
        
        for(BotInput botInput : botInputs)
        {
            BotOutput botOutput = new BotOutput();
            Boolean telefoneInvalido = isTelefone(botInput.telefoneInput);
            if(telefoneInvalido)
            {
                botOutput.validacaoTelefone = false;
            }
            else 
            {
                botOutput.validacaoTelefone = true;
            }
            botOutputReturn.add(botOutput);
        }
        
        return botOutputReturn;    
    }

    public static Boolean isTelefone(String telefone)
    {  
        return Pattern.matches('^((\\+\\d{2}\\s)?\\(\\d{2}\\)\\s?\\d{4}\\d?\\-\\d{4})?$', telefone);
    }
}