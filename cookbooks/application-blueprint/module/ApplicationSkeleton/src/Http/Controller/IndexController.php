<?php
/**
 *
 * @author Oakensoul (http://www.oakensoul.com/)
 * @link https://github.com/web-masons/application-blueprint for the canonical source repository
 * @copyright Copyright (c) 2013 Robert Gunnar Johnson Jr. and Project Contributors
 * http://opensource.org/licenses/Apache-2.0 Apache-2.0-Clause
 * @package Cornerstone
 */
namespace ApplicationBlueprint\Http\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;

class IndexController extends AbstractActionController
{

    public function indexAction ()
    {
        $view = new ViewModel();
        $view->setTemplate('application/index/index');

        return $view;
    }
}
