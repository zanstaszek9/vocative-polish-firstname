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


public class VocativePolishFirstName {

    /**
     * Structure to hold name, sex and vocative
     *
     *
     */
    private class VocativeSex {
        public final String denominatorName;
        public final String sex;
        public final String vocative;

        /**
         * @param denominatorName name in denominator (pl. mianownik) form
         * @param sex sex indication in form of letters, 'U' for 'Unable to define', 'W' for Woman, 'M' for Man
         * @param vocative name in vocative (pl. wołacz) form
         **/
        public VocativeSex(String denominatorName, String sex, String vocative) {
            this.denominatorName = denominatorName;
            this.sex = sex;
            this.vocative = vocative;
        }
    }


    /**
     * Polish definitions array for default group
     *
     * U = Unable to define
     * M = Male
     * W = Woman
     *
     */
    private final Map<String, Map<String, String>> titles = new Map<String, Map<String, String>>{
            'default' => new  Map<String, String>{
                    'U' => 'Panie/Pani',
                    'M' => 'Panie',
                    'W' => 'Pani'
            }
    };

    private VocativeSex vocative;

    private String encoding;

    /**
     * @description List of exceptions
     *
     */
    public final Map<String, VocativeSex> exceptions = new Map<String, VocativeSex>{
            'Ola' => new VocativeSex('Ola', 'W', 'Olu'),
            'Saba' => new VocativeSex('Saba', 'W', 'Sabo'),
            'Noemi' => new VocativeSex('Noemi', 'W', 'Noemi'),
            'Sonia' => new VocativeSex('Sonia', 'W', 'Soniu'),
            'Luba' => new VocativeSex('Luba', 'W', 'Lubo'),
            'Jeremi' => new VocativeSex('Jeremi', 'M', 'Jeremi'),
            'Kirył' => new VocativeSex('Kirył', 'M', 'Kiryle'),
            'Miriam' => new VocativeSex('Miriam', 'W', 'Miriam'),
            'Margot' => new VocativeSex('Margot', 'W', 'Margot'),
            'Ingrid' => new VocativeSex('Ingrid', 'W', 'Ingrid'),
            'Lew' => new VocativeSex('Lew', 'M', 'Lwie'),
            'Narcyz' => new VocativeSex('Narcyz', 'M', 'Narcyzie'),
            'Kosma' => new VocativeSex('Kosma', 'M', 'Kosmo'),
            'Bonawentura' => new VocativeSex('Bonawentura', 'M', 'Bonawenturo'),
            'Carmen' => new VocativeSex('Carmen', 'W', 'Carmen'),
            'Doris' => new VocativeSex('Doris', 'W', 'Doris'),
            'Dolores' => new VocativeSex('Dolores', 'W', 'Dolores'),
            'Abigail' => new VocativeSex('Abigail', 'W', 'Abigail'),
            'Nikolett' => new VocativeSex('Nikolett', 'W', 'Nikoletto'),
            'Ania' => new VocativeSex('Ania', 'W', 'Aniu')
    };


    /**
     * @description
     *
     * @param first_name
     * @param encoding TODO: encoding = 'UTF-8'
     * @param titles
     * @param exceptions
     **/
    public VocativePolishFirstName (String first_name, String encoding, Map<String, Map<String, String>> titles, Map<String, VocativeSex> exceptions) {
        if (!titles.isEmpty()) {
            this.setTitles(titles);
        }

        if (!exceptions.isEmpty()) {
            this.exceptions.putAll(exceptions);
        }

        this.setEncoding(encoding);
        this.remakeToVocative(first_name);
    }

    /**
     * Return default titles definition
     *
     * @return array
     */
    public  getTitles()
    {
        return this.titles['default'];
    }

    /**
     * Returns titles definition by group name
     *
     * @param string group
     * @return array
     */
    public  getTitlesByGroup(group = 'default')
    {
        return this.titles[group];
    }

    /**
     * Setup own title
     *
     * for english ex. ['U' => '', 'M' => 'Mrs.', 'W' => 'Mr.'];
     * for polish ex. ['U' => '', 'M' => 'Szanowny Panie', 'W' => 'Szanowna Pani'];
     *
     * For multiple titles definitions use group name
     * for polish ex. group: 'default' => ['U' => 'Panie/Pani', 'M' => 'Panie', 'W' => 'Pani'];
     * for polish ex. group: 'polite' => ['U' => '', 'M' => 'Szanowny Panie', 'W' => 'Szanowna Pani'];
     *
     * @param array titles
     * @param string group
     */
    public  setTitles(titles, group = 'default')
    {
        this.titles[group] = titles;
    }

    /**
     * Set string encoding
     *
     * @param encoding
     */
    public  setEncoding(encoding)
    {
        this.encoding = encoding;
    }

    /**
     * Returns array with vocative firs name and gender.
     *
     * @return array
     */
    public  getVocativeArray()
    {
        return this.vocative;
    }

    /**
     * Returns vocative first name
     *
     * @return string
     */
    public  getVocativeFirstName()
    {
        return this.vocative[1];
    }

    /**
     * Returns title
     *
     * @param string group
     * @return string
     */
    public  getDetectedTitle(group = 'default')
    {
        return this.titles[group][this.vocative[0]];
    }

    /**
     * Returns gender M - Male, W - Woman, U - Unknown
     *
     * @return string
     */
    public  getDetectedGender()
    {
        return this.vocative[0];
    }


    /**
     * Returns true if first name belongs to male
     *
     * @return bool
     */
    public  isMale()
    {
        if (this.vocative[0] == 'M') {
            return true;
        }

        return false;
    }

    /**
     * Returns true if first name belongs to woman
     *
     * @return bool
     */
    public  isWoman()
    {
        if (this.vocative[0] == 'W') {
            return true;
        }

        return false;
    }

    /**
     * Return vocative first name with title
     *
     * @param string delimiter default ' ' (space)
     * @param string group
     * @return string
     */
    public  getVocativeString(delimiter = ' ', group = 'default')
    {
        return this.getDetectedTitle(group) . delimiter . this.getVocativeFirstName();
    }

    /**
     * Convert name to first letter up
     *
     * @param string name
     * @return string
     */
    public  nameCaseConvert(name)
    {
        return mb_convert_case(mb_strtolower(name), MB_CASE_TITLE, this.encoding);
    }


    /**
     * @param string first_name
     * @return array|null
     * @throws \Exception
     */
    protected  checkExceptions(first_name)
    {
        if (!isset(this.exceptions[first_name])) {
            return null;
        }

        if (count(this.exceptions[first_name]) != 2) {
            throw new \Exception('Invalid format');
        }

        switch (this.exceptions[first_name][0]) {
            case 'M':
            case 'W':
            case 'U':
                return this.exceptions[first_name];
                break;

            default:
                throw new \Exception('Undefined gender');
        }


    /**
     * Remake first name to Polish vocative
     *
     * @param string first_name
     * @return array
     * @throws \Exception
     */
    protected  remakeToVocative(first_name)
    {
        if (empty(first_name)) {
            throw new  \Exception('First name cannot be empty');
        }

        if (empty(this._vocative)) {
            first_name = trim(this.nameCaseConvert(first_name));
            mb_internal_encoding(this._encoding);

            if ((vocative = this.checkExceptions(first_name)) !== null) {
                this._vocative = vocative;

                return;
            }

            switch (first_name) {
                case in_array(mb_substr(first_name, -2, 2), array('ni', 'li', 'zi')):
                    this._vocative = ['M', first_name];
                    break;
                case mb_substr(first_name, -2, 2) == 'eł':
                    this._vocative = ['M', mb_substr(first_name, 0, -2) . 'le'];
                    break;
                case mb_substr(first_name, -2, 2) == 'ił':
                    this._vocative = ['M', mb_substr(first_name, 0, -1) . 'le'];
                    break;
                case mb_substr(first_name, -2, 2) == 'et':
                    this._vocative = ['M', mb_substr(first_name, 0, -1) . 'cie'];
                    break;
                case mb_substr(first_name, -2, 2) == 'tr':
                    this._vocative = ['M', first_name . 'ze'];
                    break;
                case mb_substr(first_name, -2, 2) == 'ał':
                    this._vocative = ['M', mb_substr(first_name, 0, -1) . 'le'];
                    break;
                case in_array(mb_substr(first_name, -2, 2), array('it', 'rt')):
                    this._vocative = ['M', mb_substr(first_name, 0, -1) . 'cie'];
                    break;
                case mb_substr(first_name, -4, 4) == 'ciek':
                    this._vocative = ['M', mb_substr(first_name, 0, -4) . 'ćku'];
                    break;
                case mb_substr(first_name, -4, 4) == 'siek':
                    this._vocative = ['M', mb_substr(first_name, 0, -4) . 'śku'];
                    break;
                case mb_substr(first_name, -4, 4) == 'niec':
                    this._vocative = ['M', mb_substr(first_name, 0, -4) . 'ńcu'];
                    break;
                case mb_substr(first_name, -3, 3) == 'per':
                    this._vocative = ['M', mb_substr(first_name, 0, -2) . 'rze'];
                    break;
                case in_array(mb_substr(first_name, -2, 2), array('ek', 'ko')):
                    this._vocative = ['M', mb_substr(first_name, 0, -2) . 'ku'];
                    break;
                case mb_substr(first_name, -2, 2) == 'st':
                    this._vocative = ['M', mb_substr(first_name, 0, -2) . 'ście'];
                    break;
                case mb_substr(first_name, -2, 2) == 'sł':
                    this._vocative = ['M', mb_substr(first_name, 0, -2) . 'śle'];
                    break;
                case in_array(mb_substr(first_name, -3, 3),
                        array('cja', 'ria', 'lia', 'dia', 'wia', 'fia')) || in_array(mb_substr(first_name, -4, 4),
                        array('iela', 'bela', 'zula', 'saba')):
                    this._vocative = ['W', mb_substr(first_name, 0, -1) . 'o'];
                    break;
                case in_array(mb_substr(first_name, -4, 4), array('iola', 'rola')) :
                    this._vocative = ['W', mb_substr(first_name, 0, -1) . 'u'];
                    break;
                case in_array(mb_substr(first_name, -3, 3), array('aja', 'sia')) :
                    this._vocative = ['W', mb_substr(first_name, 0, -1) . 'u'];
                    break;
                case in_array(mb_substr(first_name, -2, 2), array('ja', 'ia', 'la')) :
                    this._vocative = ['W', mb_substr(first_name, 0, -1) . 'o'];
                    break;
                case mb_substr(first_name, -2, 2) == 'ba':
                    this._vocative = ['M', mb_substr(first_name, 0, -1) . 'o'];
                    break;
                case in_array(mb_substr(first_name, -2, 2), array('oe', 'ue')) :
                    this._vocative = ['M', first_name];
                    break;
                case mb_substr(first_name, -2, 2) == 'oń':
                    this._vocative = ['M', mb_substr(first_name, 0, -1) . 'niu'];
                    break;
                case in_array(mb_substr(first_name, -1, 1), array('n', 'f', 'm', 'w', 'p', 's', 'b')):
                    this._vocative = ['M', first_name . 'ie'];
                    break;
                case mb_substr(first_name, -3, 3) == 'bel':
                    this._vocative = ['M', mb_substr(first_name, 0, -3) . 'ble'];
                    break;
                case mb_substr(first_name, -2, 2) == 'ez':
                    this._vocative = ['W', first_name];
                    break;
                case in_array(mb_substr(first_name, -1, 1), array('g', 'h', 'j', 'k', 'l', 'z')):
                    this._vocative = ['M', first_name . 'u'];
                    break;
                case mb_substr(first_name, -3, 3) == 'der':
                    this._vocative = ['M', mb_substr(first_name, 0, -2) . 'rze'];
                    break;
                case mb_substr(first_name, -4, 4) == 'ster':
                    this._vocative = ['M', mb_substr(first_name, 0, -2) . 'rze'];
                    break;
                case mb_substr(first_name, -1, 1) == 'r':
                    this._vocative = ['M', first_name . 'ze'];
                    break;
                case mb_substr(first_name, -1, 1) == 'd':
                    this._vocative = ['M', first_name . 'zie'];
                    break;
                case mb_substr(first_name, -1, 1) == 'a':
                    this._vocative = ['W', mb_substr(first_name, 0, -1) . 'o'];
                    break;
                case mb_substr(first_name, -1, 1) == 'e':
                    this._vocative = ['W', first_name];
                    break;
                case mb_substr(first_name, -1, 1) == 'y':
                    this._vocative = ['M', first_name];
                    break;
                case mb_substr(first_name, -1, 1) == 'o':
                    this._vocative = ['M', first_name];
                    break;
                case mb_substr(first_name, -1, 1) == 't':
                    this._vocative = ['M', mb_substr(first_name, 0, -1) . 'cie'];
                    break;
                default:
                    this._vocative = ['U', first_name];
            }
        }
    }
}
