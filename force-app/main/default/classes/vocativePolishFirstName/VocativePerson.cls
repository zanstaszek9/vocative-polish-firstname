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
    private VocativePolishFirstName.GENDER gender;
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

    /**
     * @description Returns gender M - Male, W - Woman, U - Unknown
     *
     * @return string
     */
    public VocativePolishFirstName.GENDER getDetectedGender() {
        return this.gender;
    }


    /**
     * @description Returns true if first name belongs to man
     *
     * @return bool
     */
    public Boolean isMan() {
        return this.gender == VocativePolishFirstName.GENDER.MAN;
    }

    /**
     * @description Returns true if first name belongs to woman
     *
     * @return bool
     */
    public Boolean isWoman() {
        return this.gender == VocativePolishFirstName.GENDER.WOMAN;
    }

    /**
     * @description Returns true if gender cannot be defined by first name
     *
     * @return bool
     */
    public Boolean isUndefinable() {
        return this.gender == VocativePolishFirstName.GENDER.UNDEFINABLE;
    }

    /**
     * @description Returns true if first name are made up from names of multiple people
     *
     * @return bool
     */
    public Boolean isPlural() {
        return this.gender == VocativePolishFirstName.GENDER.PLURAL;
    }

}