/**
 * The contents of this file are subject to the license and copyright
 * detailed in the LICENSE and NOTICE files at the root of the source
 * tree and available online at
 *
 * http://www.dspace.org/license/
 */
package org.dspace.app.rest.submit.factory.impl;

import org.dspace.content.Item;
import org.dspace.content.LicenseUtils;
import org.dspace.content.WorkspaceItem;
import org.dspace.content.service.ItemService;
import org.dspace.core.Context;
import org.dspace.eperson.EPerson;
import org.dspace.services.model.Request;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Submission "add" PATCH operation
 * 
 * To accept a license the timestamp of the acceptance the client must send a
 * JSON Patch ADD operation as follow. 
 * 
 * Example: <code>
 * curl -X PATCH http://${dspace.url}/api/submission/workspaceitems/<:id-workspaceitem> -H "
 * Content-Type: application/json" -d '[{ "op": "add", "path": "
 * /sections/license/acceptanceDate", "value": "2017-11-20T10:32:42Z"}]'
 * </code>
 * 
 * Please note that according to the JSON Patch specification RFC6902 a
 * subsequent add operation on the acceptanceDate will have the effect to
 * replace the previous granted license with a new one.
 * 
 * 
 * @author Luigi Andrea Pascarelli (luigiandrea.pascarelli at 4science.it)
 *
 */
public class LicenseAddPatchOperation extends AddPatchOperation<String> {

	@Autowired
	ItemService itemService;

	@Override
	protected Class<String[]> getArrayClassForEvaluation() {
		return String[].class;
	}

	@Override
	protected Class<String> getClassForEvaluation() {
		return String.class;
	}

	@Override
	void add(Context context, Request currentRequest, WorkspaceItem source, String path, Object value)
			throws Exception {
		Item item = source.getItem();
		EPerson submitter = context.getCurrentUser();

		// remove any existing DSpace license (just in case the user
		// accepted it previously)
		itemService.removeDSpaceLicense(context, item);

		String license = LicenseUtils.getLicenseText(context.getCurrentLocale(), source.getCollection(), item,
				submitter);

		LicenseUtils.grantLicense(context, item, license, (String) value);
	}

}
