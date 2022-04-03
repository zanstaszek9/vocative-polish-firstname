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

/**
* @description Structure to hold name, gender and vocative
*/
public with sharing class VocativePerson {
    private final static String commonConjunction = 'i';

    public final String denominatorName;
    public VocativePolishFirstName.GENDER gender;
    public String vocative = '';

    /**
     * @description
     * @param denominatorName name in denominator (pl. mianownik) form
     * @param gender gender indication in form of letters
     * @param vocative name in vocative (pl. wołacz) form
     **/
    public VocativePerson(String denominatorName, VocativePolishFirstName.GENDER gender, String vocative) {
        this.denominatorName = denominatorName;
        this.gender = gender;
        this.vocative = vocative;
    }

    /**
     * @description
     * @param denominatorName name in denominator (pl. mianownik) form
     **/
    public VocativePerson(String denominatorName) {
        this(denominatorName, null, '');
    }

    public Boolean hasDefinedVocativeAndGender() {
        return String.isNotBlank(this.vocative) && this.gender != null;
    }


    public void attachConjunction(String aString) {
        if (isConjunctionBetweenTwoNames(aString)) {
            this.gender = VocativePolishFirstName.GENDER.PLURAL;
        }
        this.vocative += aString;
    }

    public void attachToVocativePerson(String denominatorName, VocativeRule vocativeRule) {
        this.gender = (this.gender == null) ? this.gender = vocativeRule.gender : this.gender;
        this.vocative += vocativeRule.getVocativeName(denominatorName);
    }

    private static Boolean isConjunctionBetweenTwoNames(String aString){
        return aString == commonConjunction;
    }

}