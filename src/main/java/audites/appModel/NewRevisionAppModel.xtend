package audites.appModel

import audites.domain.Department
import audites.domain.Requirement
import audites.domain.Revision
import audites.domain.User
import audites.repos.RepoDepartments
import audites.repos.RepoRevisions
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class NewRevisionAppModel extends MainApplicationAppModel {

	List<Department> departments
	Revision revision
	Requirement selectedRequirement
	Department selectedDepartment

	new() {
		departments = RepoDepartments.instance.allInstances
		revision = new Revision
		selectedRequirement = new Requirement
		selectedDepartment = null
	}

	new(User user) {
		super(user)
		departments = RepoDepartments.instance.allInstances
		revision = new Revision
		selectedRequirement = new Requirement
		selectedDepartment = null
	}

	new(Requirement requirement, Revision revision) {
		this.revision = revision
		this.selectedRequirement = requirement
	}

	new(Revision revision) {
		this.revision = revision
	}

	def List<Department> getDepartments() {
		var list = newArrayList()
		val allDep = RepoDepartments.instance.allInstances
		for (Department d : allDep) {
			if (!list.contains(d) && d.name != "") {
				list.add(d)
			}
		}
		return list
	}

	def createRevison() {
		revision.author = userLoged
		revision.responsable = selectedDepartment
		userLoged.revisions.add(revision)
		selectedDepartment.addRevision(revision)
		RepoRevisions.instance.create(revision)
		RepoDepartments.instance.update(selectedDepartment)
	}

	def deleteRequirement() {
		// RepoRequirements.instance.remove(selectedRequirement)
		revision.requirements.remove(selectedRequirement)
		RepoRevisions.instance.update(revision)
	}

	@Dependencies("selectedRequirement")
	def boolean getHasRequirements() {
		selectedRequirement.name != ""
	}

	def String getRevisionName() {
		this.revision.name
	}

	def void setRevisionName(String name) {
		revision.name = name
		RepoRevisions.instance.update(revision)
	}

}
