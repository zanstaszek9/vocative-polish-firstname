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
private class VocativePolishFirstNameTest {

    @IsTest
    static void createContactAndSetVocativeRelatedFields() {
        final Contact contact = new Contact(FirstName = 'Konrad');
        final VocativePolishFirstName nameWithVocative = VocativePolishFirstName.prepareContact(contact);

        System.assertEquals('Konradzie', contact.VPFN_Polish_Vocative__c);
        System.assertEquals('Panie', contact.VPFN_Vocative_Salutation__c);
        System.assertEquals('Man', contact.VPFN_Gender__c);
//        System.assertEquals('Mr.', contact.Salutation); //TODO
    }

    @IsTest
    static void checkAgainstAllVocativesFromFile() {
        final Map<String, String> namesWithWrongVocative = new Map<String, String>();
        final Map<String, String> namesWithWrongGender = new Map<String, String>();
        //given
        final List<Contact> contacts = (List<Contact>) Test.loadData(Contact.SObjectType, 'imiona');

        //when
        for (Contact  contact : contacts) {
            final VocativePolishFirstName nameWithVoc = new VocativePolishFirstName(contact.FirstName);
            if (contact.LastName != nameWithVoc.getFirstNameInVocative()){
                namesWithWrongVocative.put(contact.LastName, nameWithVoc.getFirstNameInVocative());
            }
            final VocativePolishFirstName.GENDER mappedGender = genderMapping(contact.Gender__c);
            if (mappedGender != nameWithVoc.getDetectedGender()){
                namesWithWrongGender.put(contact.Gender__c, nameWithVoc.getDetectedGender().name());
            }
        }
        //then
        System.assert(namesWithWrongVocative.isEmpty(), namesWithWrongVocative.size() + ' vocatives were wrong: ' + namesWithWrongVocative);
        System.assert(namesWithWrongGender.isEmpty(), namesWithWrongGender.size() + ' genders were wrong: ' + namesWithWrongGender);
    }

    private static VocativePolishFirstName.GENDER genderMapping(String gender){
        if (gender == 'P')
            return VocativePolishFirstName.GENDER.PLURAL;
        else if (gender == 'U')
            return VocativePolishFirstName.GENDER.UNDEFINABLE;
        else if (gender == 'M')
            return VocativePolishFirstName.GENDER.MAN;
        else if (gender == 'W')
            return VocativePolishFirstName.GENDER.WOMAN;
        else return null;
    }

    @IsTest
    static void shouldProcessCorrectlyOnPolishDiacritics() {
        System.assertEquals('Bogusądzie', new VocativePolishFirstName('Bogusąd').getFirstNameInVocative());
        System.assertEquals('Więcemile', new VocativePolishFirstName('Więcemił').getFirstNameInVocative());
        System.assertEquals('Kiryle', new VocativePolishFirstName('Kirył').getFirstNameInVocative());
        System.assertEquals('Czechoniu', new VocativePolishFirstName('Czechoń').getFirstNameInVocative());
        System.assertEquals('Mściwóju', new VocativePolishFirstName('Mściwój').getFirstNameInVocative());
        System.assertEquals('Świętopełku', new VocativePolishFirstName('Świętopełk').getFirstNameInVocative());
        System.assertEquals('Andżeliko', new VocativePolishFirstName('Andżelika').getFirstNameInVocative());


    }

    @IsTest
    static void shouldReturnProperTitlesForDefaultGenders() {
        System.assert(new VocativePolishFirstName('Krzysztof').getVocativeStringWithTitle().startsWith('Panie'));
        System.assert(new VocativePolishFirstName('Alicja').getVocativeStringWithTitle().startsWith('Pani'));
        System.assert(new VocativePolishFirstName('Maliq').getVocativeStringWithTitle().startsWith('Panie/Pani'));
        System.assert(new VocativePolishFirstName('Krzysztof i Alicja').getVocativeStringWithTitle().startsWith('Państwo'));
    }

    @IsTest
    static void shouldReturnProperGender() {
        System.assertEquals(VocativePolishFirstName.GENDER.MAN, new VocativePolishFirstName('Krzysztof').getDetectedGender());
        System.assertEquals(VocativePolishFirstName.GENDER.WOMAN, new VocativePolishFirstName('Alicja').getDetectedGender());
        System.assertEquals(VocativePolishFirstName.GENDER.UNDEFINABLE, new VocativePolishFirstName('Maliq').getDetectedGender());
    }

    @IsTest
    static void shouldReturnProperGenderForDoubleNames() {
        System.assertEquals(VocativePolishFirstName.GENDER.MAN, new VocativePolishFirstName('Jan-Krzysztof').getDetectedGender());
        System.assertEquals(VocativePolishFirstName.GENDER.WOMAN, new VocativePolishFirstName('Anna-Alicja').getDetectedGender());
        System.assertEquals(VocativePolishFirstName.GENDER.MAN, new VocativePolishFirstName('Jan Maria').getDetectedGender());
        System.assertEquals(VocativePolishFirstName.GENDER.WOMAN, new VocativePolishFirstName('Maria Jan').getDetectedGender());
    }

    @IsTest
    static void shouldReturnProperGenderTwoNames() {
        System.assertEquals(VocativePolishFirstName.GENDER.PLURAL, new VocativePolishFirstName('Tomasz i Julia').getDetectedGender());
        System.assertEquals(VocativePolishFirstName.GENDER.PLURAL, new VocativePolishFirstName('Julia i Tomasz').getDetectedGender());
    }


    @IsTest
    static void shouldReturnTrueForMaleName() {
        System.assert(new VocativePolishFirstName('Krzysztof').isMan());
    }

    @IsTest
    static void shouldReturnTrueForFemaleName() {
        System.assert(new VocativePolishFirstName('Alicja').isWoman());
    }

    @IsTest
    static void shouldReturnTrueForUndefinableName() {
        System.assert(new VocativePolishFirstName('Maliq').isUndefinable());
    }

    @IsTest
    static void shouldReturnTrueForNamesOfTwoPeople() {
        System.assert(new VocativePolishFirstName('Krzysztof i Alicja').isPlural());
    }

    @IsTest
    static void shouldCapitalizeDoubleName() {
        System.assertEquals('Jan Krzysztof', VocativePolishFirstName.nameCaseConvert('jan krzysztof'));
    }


    @IsTest
    static void shouldProcessDoubleBarreledName() {
        System.assertEquals('Janie-Krzysztofie', new VocativePolishFirstName('Jan-Krzysztof').getFirstNameInVocative());
    }

    @IsTest
    static void shouldProcessDoubleName() {
        System.assertEquals('Janie Mario', new VocativePolishFirstName('Jan Maria').getFirstNameInVocative());
    }

    @IsTest
    static void shouldProcessTwoNamesWithConjunction() {
        System.assertEquals('Janie i Mario', new VocativePolishFirstName('Jan i Maria').getFirstNameInVocative());
    }
}