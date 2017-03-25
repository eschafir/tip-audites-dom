package audites.domain

import java.time.LocalDate
import java.util.Date
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import java.util.Calendar

@Observable
@Accessors
@Entity
class Revision {

	@Id
	@GeneratedValue
	private Long id

	@ManyToOne(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	User author

	@Column
	String name

	@Column
	String description

	@Column
	Date initDate

	@Column
	Date endDate

	@ManyToOne(cascade=CascadeType.ALL)
	Department responsable

	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	Set<Requirement> requirements = newHashSet()

	new() {
		author = new User
		name = ""
		description = ""
		initDate = Calendar.instance.time
		endDate = new Date(2017, 04, 16)
		responsable = new Department
	}

	def addRequirement(Requirement r) {
		if (!requirements.contains(r)) {
			requirements.add(r)
		}
	}

	def int completedRequirements() {
		var amount = 0
		for (Requirement r : requirements) {
			//
		}
		return amount
	}

	def float average() {
		return ((completedRequirements * 100) / requirements.size)
	}

	def Boolean isCompleted() {
		return (completedRequirements == requirements.size)
	}

}
