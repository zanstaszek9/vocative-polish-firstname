/**
 * Created by Stanislaw Zan, zanstaszek9@gmail.com on 08.02.2022.
 */

@IsTest
private class VocativePolishFirstNameTest {

    @IsTest
    static void testBehavior() {
        List<Contact> contacts = (List<Contact>) Test.loadData(Contact.SObjectType, 'imiona');
        for (Integer i = 0; i < 10; i++) {
            System.debug('%%% STZAN1 class: VocativePolishFirstNameTest, method: testBehavior; 2022-02-8, contacts: ' + contacts[i]);
        }


    }
}