public abstract class Charset {

    /**
     * Convenience method that encodes a string into bytes in charset.
     * <p>
     * @param  input string of Unicode characters
     * @param  charset name according to http://www.iana.org/assignments/character-sets/character-sets.xhtml
     * @return binary characters in charset
     */
    public static Blob encode(final String input, final String charset) {
        String inputEncode = EncodingUtil.urlEncode(input, charset);
        inputEncode = inputEncode.replace('+', '%20');
        if (charset == 'UTF-16LE') {
            inputEncode = inputEncode.replace('%20', '%20%00');
        }
		
        final Matcher m =
            Pattern.compile('(.*?)%([0-9A-F]{2})|(.+)')
            .matcher(inputEncode);
        String hex = '';

        while (m.find()) {
            if (String.isBlank(m.group(1)) != true) {
                hex += toHexUTF16(EncodingUtil.convertToHex(Blob.valueOf(m.group(1))), charset);
            }
            if (String.isBlank(m.group(2)) != true) {
                hex += m.group(2);
            }
            if (String.isBlank(m.group(3)) != true) {
                hex += toHexUTF16(EncodingUtil.convertToHex(Blob.valueOf(m.group(3))), charset);
            }
        }
        return EncodingUtil.convertFromHex(hex);
    }

    // @isTest
    public static void test_encode() {
        System.assertEquals('2b3a418f8e99',
                            EncodingUtil.convertToHex(Charset.encode('+:AÅÄÖ',
                                                                     'cp437')));
    }

    /**
     * Convenience method that decodes bytes in charset into a string of Unicode
     * characters.
     * <p>
     * @param  input binary characters in charset
     * @param  charset name according to http://www.iana.org/assignments/character-sets/character-sets.xhtml
     * @return string of Unicode characters
     */
    public static String decode(final Blob input, final String charset){
        final String hex = EncodingUtil.convertToHex(input);
        final Integer size = hex.length() >> 1;
        final List<String> bytes = new String[size];

        for (Integer i = 0; i < size; ++i) {
            bytes.set(i, hex.mid(i << 1, 2));
        }
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), charset);
    }

    // @isTest
    public static void test_decode() {
        System.assertEquals('+:AÅÄÖ',
                            Charset.decode(EncodingUtil.convertFromHex('2b3a418f8e99'),
                                           'cp437'));
    }
     
    /**
     * Returns a correct hexadecimal (base 16) representation of the inputString (Compatible for UTF-16LE). 
     * @param  input string of Unicode characters
     * @param  charset name according to http://www.iana.org/assignments/character-sets/character-sets.xhtml
     * @return Unicode characters in charset
     */
    public static String toHexUTF16(String inputString, String charSet) {
        if (charSet != 'UTF-16LE') return inputString;
        
        final Integer size = inputString.length() >> 1;
        final List<String> bytes = new String[size];

        for (Integer i = 0; i < size; ++i) {
            bytes.set(i, inputString.mid(i << 1, 2));
        }
        String rtn = String.join(bytes, '00') + '00';
        return rtn;
    }
}