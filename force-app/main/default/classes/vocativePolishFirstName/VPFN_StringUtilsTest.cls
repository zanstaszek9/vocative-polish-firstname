/**
 * VocativePolishFirstName
 *
 * Component for remake first name to Polish vocative
 *
 * @author  Mariusz Mielnik <mariusz@ecbox.pl>
 * @author  Stanislaw Zan <zanstaszek9@gmail.com>
 * @license  MIT
 *
 */

@IsTest
private class VPFN_StringUtilsTest {

    @IsTest
    static void checkIfStringEndsWithSpecifiedStrings() {
        System.assert(VPFN_StringUtils.endsWithAnySpecifiedIgnoreCase('Ada', new Set<String> {'a'}));
        System.assert(VPFN_StringUtils.endsWithAnySpecifiedIgnoreCase('Ada', new Set<String> {'b', 'a'}));
        System.assert(VPFN_StringUtils.endsWithAnySpecifiedIgnoreCase('Ada', new Set<String> {''}));

        System.assert(!VPFN_StringUtils.endsWithAnySpecifiedIgnoreCase('Ada', new Set<String> {'b'}));
        System.assert(!VPFN_StringUtils.endsWithAnySpecifiedIgnoreCase('Ada', new Set<String> {'longerThanName'}));

    }

    @IsTest
    static void shouldRemoveSpecifiedAmountOfLettersFromRight(){
        System.assertEquals('', VPFN_StringUtils.chopString('Ada', 3));
        System.assertEquals('A', VPFN_StringUtils.chopString('Ada', 2));
        System.assertEquals('Ada', VPFN_StringUtils.chopString('Ada', 0));

        try {
            VPFN_StringUtils.chopString('Ada', -1);
        }
        catch(StringException e) {
            System.assertEquals('Ending position out of bounds: 4', e.getMessage(), 'Should throw StringException and specify position of 4. ');
        }

        try {
            VPFN_StringUtils.chopString('Ada', 4);
        }
        catch(StringException e) {
            System.assertEquals('Ending position out of bounds: -1', e.getMessage(), 'Should throw StringException and specify position of -1. ');
        }
    }

}